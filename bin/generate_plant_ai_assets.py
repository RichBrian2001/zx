from __future__ import annotations

import argparse
import json
import os
import sys
import time
import urllib.error
import urllib.parse
import urllib.request
from io import BytesIO
from pathlib import Path

from PIL import Image


ROOT = Path(__file__).resolve().parents[1]
PROMPT_MANIFEST_PATH = ROOT / "demo-assets" / "plant-image-prompt-manifest.json"
DEFAULT_API_URL = "https://open.bigmodel.cn/api/paas/v4/images/generations"
DEFAULT_MODEL = "glm-image"
DEFAULT_SIZE = "1344x1024"
DEFAULT_QUALITY = "hd"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Generate plant images from the Zhipu image API using the prompt manifest."
    )
    parser.add_argument(
        "--manifest",
        type=Path,
        default=PROMPT_MANIFEST_PATH,
        help="Path to the plant image prompt manifest JSON file.",
    )
    parser.add_argument(
        "--api-key",
        default=os.environ.get("ZHIPU_API_KEY", ""),
        help="Zhipu API key. Defaults to the ZHIPU_API_KEY environment variable.",
    )
    parser.add_argument(
        "--api-url",
        default=DEFAULT_API_URL,
        help="Zhipu image generation endpoint.",
    )
    parser.add_argument(
        "--model",
        default=DEFAULT_MODEL,
        help="Image generation model name.",
    )
    parser.add_argument(
        "--size",
        default=DEFAULT_SIZE,
        help="Requested image size, for example 1024x1024 or 1280x1280.",
    )
    parser.add_argument(
        "--quality",
        default=DEFAULT_QUALITY,
        help="Requested quality value passed to the API.",
    )
    parser.add_argument(
        "--watermark-enabled",
        action="store_true",
        help="Request watermarked output from the API.",
    )
    parser.add_argument(
        "--overwrite",
        action="store_true",
        help="Overwrite existing files instead of only generating missing files.",
    )
    parser.add_argument(
        "--limit",
        type=int,
        default=0,
        help="Maximum number of images to generate in this run. 0 means no limit.",
    )
    parser.add_argument(
        "--plant-ids",
        default="",
        help="Comma-separated list of plant IDs to generate. Leave empty to use all items.",
    )
    parser.add_argument(
        "--sleep-seconds",
        type=float,
        default=1.0,
        help="Delay between requests to avoid hitting service limits.",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Print what would be generated without calling the API.",
    )
    return parser.parse_args()


def load_manifest(path: Path) -> dict:
    with path.open("r", encoding="utf-8") as file:
        return json.load(file)


def render_prompt(item: dict, manifest: dict) -> str:
    template = (manifest.get("template") or "").strip()
    if not template:
        return item.get("prompt", "")
    return (
        template
        .replace("[植物名称]", item.get("plantName", ""))
        .replace("[细节特征]", item.get("detailFeature", ""))
    )


def resolve_target_path(item: dict) -> Path:
    runtime_path = (item.get("runtimePath") or "").strip()
    if runtime_path.startswith("/profile/upload/"):
        relative_path = runtime_path.removeprefix("/profile/upload/")
        return ROOT / "demo-assets" / "uploadPath" / "upload" / relative_path

    repo_relative_path = (item.get("repoRelativePath") or "").strip()
    if repo_relative_path:
        return ROOT / repo_relative_path

    raise ValueError(f"No writable target path found for item: {item}")


def parse_plant_ids(raw_ids: str) -> set[int]:
    if not raw_ids.strip():
        return set()
    values: set[int] = set()
    for chunk in raw_ids.split(","):
        chunk = chunk.strip()
        if not chunk:
            continue
        values.add(int(chunk))
    return values


def build_headers(api_key: str) -> dict[str, str]:
    return {
        "Authorization": f"Bearer {api_key}",
        "Content-Type": "application/json",
    }


def build_request_body(prompt: str, model: str, size: str, quality: str, watermark_enabled: bool) -> bytes:
    payload = {
        "model": model,
        "prompt": prompt,
        "size": size,
        "watermark_enabled": watermark_enabled,
        "quality": quality,
    }
    return json.dumps(payload, ensure_ascii=False).encode("utf-8")


def request_generation(api_url: str, headers: dict[str, str], body: bytes) -> str:
    request = urllib.request.Request(api_url, data=body, headers=headers, method="POST")
    with urllib.request.urlopen(request, timeout=180) as response:
        payload = json.loads(response.read().decode("utf-8"))
    data = payload.get("data") or []
    if not data:
        raise RuntimeError(f"Image API returned no data: {payload}")
    image_url = data[0].get("url")
    if not image_url:
        raise RuntimeError(f"Image API returned no url: {payload}")
    return image_url


def download_file(url: str, destination: Path) -> None:
    destination.parent.mkdir(parents=True, exist_ok=True)
    with urllib.request.urlopen(url, timeout=180) as response:
        content = response.read()
    save_image_content(content, destination)


def save_image_content(content: bytes, destination: Path) -> None:
    suffix = destination.suffix.lower()
    if suffix in {".jpg", ".jpeg"}:
        image = Image.open(BytesIO(content))
        if image.mode != "RGB":
            image = image.convert("RGB")
        image.save(destination, format="JPEG", quality=95, optimize=True)
        return
    destination.write_bytes(content)


def select_items(items: list[dict], only_ids: set[int], overwrite: bool) -> list[dict]:
    selected: list[dict] = []
    for item in items:
        if only_ids and item["plantId"] not in only_ids:
            continue
        target_path = resolve_target_path(item)
        if not overwrite and target_path.exists():
            continue
        selected.append(item)
    return selected


def main() -> int:
    args = parse_args()
    if not args.api_key:
        print("Missing API key. Pass --api-key or set ZHIPU_API_KEY.", file=sys.stderr)
        return 2

    manifest = load_manifest(args.manifest)
    items = manifest.get("items") or []
    only_ids = parse_plant_ids(args.plant_ids)
    selected = select_items(items, only_ids, args.overwrite)
    if args.limit > 0:
        selected = selected[: args.limit]

    if not selected:
        print("No images selected for generation.")
        return 0

    headers = build_headers(args.api_key)
    total = len(selected)
    print(f"Preparing to generate {total} image(s).")

    failures: list[tuple[int, str]] = []
    for index, item in enumerate(selected, start=1):
        target_path = resolve_target_path(item)
        print(f"[{index}/{total}] {item['plantName']} -> {target_path.relative_to(ROOT)}")
        if args.dry_run:
            continue
        try:
            prompt = render_prompt(item, manifest)
            body = build_request_body(
                prompt=prompt,
                model=args.model,
                size=args.size,
                quality=args.quality,
                watermark_enabled=args.watermark_enabled,
            )
            image_url = request_generation(args.api_url, headers, body)
            download_file(image_url, target_path)
            print(f"Saved from {image_url}")
            if "_watermark" in image_url:
                print("Warning: API still returned a watermarked asset URL.")
        except urllib.error.HTTPError as error:
            details = error.read().decode("utf-8", errors="replace")
            failures.append((item["plantId"], f"HTTP {error.code}: {details}"))
            print(f"Failed: HTTP {error.code}")
        except Exception as error:  # noqa: BLE001
            failures.append((item["plantId"], str(error)))
            print(f"Failed: {error}")
        time.sleep(max(args.sleep_seconds, 0.0))

    if failures:
        print("Generation finished with failures:")
        for plant_id, message in failures:
            print(f"- {plant_id}: {message}")
        return 1

    print("Generation finished successfully.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())