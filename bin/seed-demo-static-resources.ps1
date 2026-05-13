param(
    [string]$ProfilePath,
    [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-RepoRoot {
    return (Split-Path -Parent $PSScriptRoot)
}

function Get-ProfilePathFromConfig {
    param(
        [string]$ConfigPath
    )

    $match = Select-String -Path $ConfigPath -Pattern '^\s*profile:\s*(.+)$' | Select-Object -First 1
    if (-not $match) {
        throw "Could not resolve ruoyi.profile from $ConfigPath"
    }
    return $match.Matches[0].Groups[1].Value.Trim()
}

function Get-InsertRows {
    param(
        [string]$SqlPath,
        [string]$TableName
    )

    $rows = New-Object System.Collections.Generic.List[string]
    $collect = $false
    $seenValues = $false
    foreach ($line in Get-Content -Path $SqlPath -Encoding UTF8) {
        if (-not $collect) {
            if ($line -match "^\s*insert into\s+$TableName\b") {
                $collect = $true
                $seenValues = $false
            }
            continue
        }

        $trimmed = $line.Trim()
        if (-not $trimmed -or $trimmed.StartsWith('--')) {
            continue
        }

        if ($trimmed -eq 'values') {
            $seenValues = $true
            continue
        }

        if (-not $seenValues -or -not $trimmed.StartsWith('(')) {
            continue
        }

        $rows.Add($trimmed.TrimEnd(',').TrimEnd(';'))
        if ($trimmed.EndsWith(';')) {
            break
        }
    }

    return $rows
}

function Split-SqlValues {
    param(
        [string]$Tuple
    )

    $content = $Tuple.Trim().TrimStart('(').TrimEnd(')')
    return [regex]::Split($content, ",(?=(?:[^']*'[^']*')*[^']*$)") | ForEach-Object { $_.Trim() }
}

function Unquote-SqlValue {
    param(
        [string]$Value
    )

    if ($Value -eq 'null') {
        return ''
    }

    if ($Value.Length -ge 2 -and $Value.StartsWith("'") -and $Value.EndsWith("'")) {
        return $Value.Substring(1, $Value.Length - 2)
    }

    return $Value
}

function Ensure-Directory {
    param(
        [string]$Path
    )

    if (-not (Test-Path -Path $Path)) {
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
    }
}

function Get-TargetPath {
    param(
        [string]$RootPath,
        [string]$ResourcePath
    )

    $relative = $ResourcePath.Substring('/profile/'.Length).Replace('/', '\\')
    return Join-Path $RootPath $relative
}

function New-ColorFromHex {
    param(
        [string]$Hex,
        [int]$Alpha = 255
    )

    $clean = $Hex.TrimStart('#')
    return [System.Drawing.Color]::FromArgb(
        $Alpha,
        [Convert]::ToInt32($clean.Substring(0, 2), 16),
        [Convert]::ToInt32($clean.Substring(2, 2), 16),
        [Convert]::ToInt32($clean.Substring(4, 2), 16)
    )
}

function Get-Palette {
    param(
        [int]$Index
    )

    $palettes = @(
        @{ Primary = '#4E7A5D'; Secondary = '#CFE3D2'; Accent = '#E9F4E4'; Glow = '#A7C69D' },
        @{ Primary = '#6B8F56'; Secondary = '#E4E8C9'; Accent = '#F4F5E6'; Glow = '#C1D8A3' },
        @{ Primary = '#5E7253'; Secondary = '#D7C9A1'; Accent = '#F0E5C8'; Glow = '#B8AA7B' },
        @{ Primary = '#3D5E4E'; Secondary = '#B9D3C1'; Accent = '#E3F0E7'; Glow = '#8DB59E' },
        @{ Primary = '#546B3A'; Secondary = '#D7D9B3'; Accent = '#F2EFD8'; Glow = '#B7C489' },
        @{ Primary = '#7A8F71'; Secondary = '#E8E3D5'; Accent = '#FBF8EF'; Glow = '#C9D4B9' },
        @{ Primary = '#49635A'; Secondary = '#C7D7D0'; Accent = '#EDF3F0'; Glow = '#8EB5A4' },
        @{ Primary = '#42584A'; Secondary = '#CFD4C6'; Accent = '#EFF2EB'; Glow = '#97A995' },
        @{ Primary = '#657D68'; Secondary = '#DEE6D8'; Accent = '#F6F8F1'; Glow = '#B5C8AD' },
        @{ Primary = '#8A6A3C'; Secondary = '#E8D3A7'; Accent = '#FBF1D8'; Glow = '#D2AF63' },
        @{ Primary = '#51775B'; Secondary = '#D5E5C7'; Accent = '#F1F8E8'; Glow = '#A3CB8E' },
        @{ Primary = '#4A736F'; Secondary = '#D5E7E3'; Accent = '#F2FAF8'; Glow = '#9CCFCB' }
    )

    return $palettes[$Index % $palettes.Count]
}

function New-FontSafe {
    param(
        [float]$Size,
        [System.Drawing.FontStyle]$Style = [System.Drawing.FontStyle]::Regular
    )

    foreach ($fontName in @('Microsoft YaHei UI', 'Microsoft YaHei', 'Segoe UI', 'Arial')) {
        try {
            return New-Object System.Drawing.Font($fontName, $Size, $Style)
        }
        catch {
        }
    }

    throw 'Could not resolve a usable font.'
}

function New-DemoCover {
    param(
        [string]$OutputPath,
        [string]$Badge,
        [string]$Title,
        [string]$Subtitle,
        [string]$Detail,
        [int]$Index,
        [switch]$ForceWrite
    )

    if ((Test-Path -Path $OutputPath) -and -not $ForceWrite) {
        return
    }

    $palette = Get-Palette -Index $Index
    $bitmap = New-Object System.Drawing.Bitmap 1200, 675
    $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
    $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $graphics.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit

    $bounds = New-Object System.Drawing.Rectangle 0, 0, 1200, 675
    $gradient = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
        $bounds,
        (New-ColorFromHex $palette.Primary),
        (New-ColorFromHex $palette.Secondary),
        25.0
    )
    $graphics.FillRectangle($gradient, $bounds)

    $overlayBrush = New-Object System.Drawing.SolidBrush((New-ColorFromHex $palette.Primary 68))
    $graphics.FillRectangle($overlayBrush, 56, 56, 540, 563)

    $glowBrush = New-Object System.Drawing.SolidBrush((New-ColorFromHex $palette.Glow 70))
    $accentBrush = New-Object System.Drawing.SolidBrush((New-ColorFromHex $palette.Accent 90))
    $graphics.FillEllipse($glowBrush, 760, 70, 280, 280)
    $graphics.FillEllipse($accentBrush, 860, 210, 170, 170)
    $graphics.FillEllipse($glowBrush, 680, 320, 220, 220)

    $linePen = New-Object System.Drawing.Pen((New-ColorFromHex $palette.Accent 180), 6)
    $graphics.DrawBezier($linePen, 700, 480, 760, 310, 980, 370, 1040, 190)
    $graphics.DrawBezier($linePen, 650, 560, 760, 430, 930, 580, 1070, 360)
    $graphics.DrawLine($linePen, 820, 520, 930, 160)
    $graphics.DrawLine($linePen, 930, 520, 1040, 240)

    $titleFont = New-FontSafe -Size 42 -Style ([System.Drawing.FontStyle]::Bold)
    $subtitleFont = New-FontSafe -Size 18 -Style ([System.Drawing.FontStyle]::Regular)
    $badgeFont = New-FontSafe -Size 14 -Style ([System.Drawing.FontStyle]::Bold)
    $detailFont = New-FontSafe -Size 16 -Style ([System.Drawing.FontStyle]::Regular)

    $badgeBrush = New-Object System.Drawing.SolidBrush((New-ColorFromHex $palette.Accent 210))
    $badgeTextBrush = New-Object System.Drawing.SolidBrush((New-ColorFromHex $palette.Primary))
    $titleBrush = [System.Drawing.Brushes]::White
    $subtitleBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(236, 250, 250, 248))
    $detailBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(218, 246, 246, 243))
    $titleBounds = New-Object System.Drawing.RectangleF(82, 155, 470, 130)
    $subtitleBounds = New-Object System.Drawing.RectangleF(84, 310, 460, 70)
    $detailBounds = New-Object System.Drawing.RectangleF(84, 382, 450, 165)

    $graphics.FillRectangle($badgeBrush, 86, 92, 132, 34)
    $graphics.DrawString($Badge, $badgeFont, $badgeTextBrush, 98, 99)
    $graphics.DrawString($Title, $titleFont, $titleBrush, $titleBounds)
    $graphics.DrawString($Subtitle, $subtitleFont, $subtitleBrush, $subtitleBounds)
    $graphics.DrawString($Detail, $detailFont, $detailBrush, $detailBounds)

    $codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
    $encoderParams = New-Object System.Drawing.Imaging.EncoderParameters 1
    $encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, 92L)
    $bitmap.Save($OutputPath, $codec, $encoderParams)

    $gradient.Dispose()
    $overlayBrush.Dispose()
    $glowBrush.Dispose()
    $accentBrush.Dispose()
    $linePen.Dispose()
    $titleFont.Dispose()
    $subtitleFont.Dispose()
    $badgeFont.Dispose()
    $detailFont.Dispose()
    $badgeBrush.Dispose()
    $badgeTextBrush.Dispose()
    $subtitleBrush.Dispose()
    $detailBrush.Dispose()
    $graphics.Dispose()
    $bitmap.Dispose()
}

function ConvertTo-ExcelColumnName {
    param(
        [int]$ColumnNumber
    )

    $dividend = $ColumnNumber
    $columnName = ''
    while ($dividend -gt 0) {
        $modulo = ($dividend - 1) % 26
        $columnName = [char](65 + $modulo) + $columnName
        $dividend = [math]::Floor(($dividend - $modulo) / 26)
    }
    return $columnName
}

function Escape-Xml {
    param(
        [string]$Text
    )

    return [System.Security.SecurityElement]::Escape($Text)
}

function New-XlsxFile {
    param(
        [string]$OutputPath,
        [string]$SheetName,
        [object[]]$Headers,
        [object[]]$Rows,
        [switch]$ForceWrite
    )

    if ((Test-Path -Path $OutputPath) -and -not $ForceWrite) {
        return
    }

    Add-Type -AssemblyName System.IO.Compression
    Add-Type -AssemblyName System.IO.Compression.FileSystem

    $sheetBuilder = New-Object System.Text.StringBuilder
    [void]$sheetBuilder.Append('<sheetData>')

    $appendRow = {
        param(
            [object[]]$Cells,
            [int]$CurrentRowIndex
        )

        [void]$sheetBuilder.Append(('<row r="{0}">' -f $CurrentRowIndex))
        for ($columnIndex = 1; $columnIndex -le $Cells.Count; $columnIndex++) {
            $cellRef = "$(ConvertTo-ExcelColumnName -ColumnNumber $columnIndex)$CurrentRowIndex"
            $cellValue = Escape-Xml -Text ([string]$Cells[$columnIndex - 1])
            [void]$sheetBuilder.Append(('<c r="{0}" t="inlineStr"><is><t xml:space="preserve">{1}</t></is></c>' -f $cellRef, $cellValue))
        }
        [void]$sheetBuilder.Append('</row>')
    }

    $rowIndex = 1
    & $appendRow @($Headers | ForEach-Object { $_.Title }) $rowIndex
    $rowIndex++
    foreach ($dataRow in $Rows) {
        & $appendRow $dataRow $rowIndex
        $rowIndex++
    }
    [void]$sheetBuilder.Append('</sheetData>')

    $worksheetXml = @"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">$sheetBuilder</worksheet>
"@
    $workbookXml = @"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"><sheets><sheet name="$SheetName" sheetId="1" r:id="rId1"/></sheets></workbook>
"@
    $workbookRelsXml = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet1.xml"/><Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/></Relationships>'
    $stylesXml = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><styleSheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main"><fonts count="1"><font><sz val="11"/><name val="Calibri"/></font></fonts><fills count="1"><fill><patternFill patternType="none"/></fill></fills><borders count="1"><border/></borders><cellStyleXfs count="1"><xf numFmtId="0" fontId="0" fillId="0" borderId="0"/></cellStyleXfs><cellXfs count="1"><xf numFmtId="0" fontId="0" fillId="0" borderId="0" xfId="0"/></cellXfs></styleSheet>'
    $contentTypesXml = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types"><Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/><Default Extension="xml" ContentType="application/xml"/><Override PartName="/xl/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/><Override PartName="/xl/worksheets/sheet1.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/><Override PartName="/xl/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml"/><Override PartName="/docProps/core.xml" ContentType="application/vnd.openxmlformats-package.core-properties+xml"/><Override PartName="/docProps/app.xml" ContentType="application/vnd.openxmlformats-officedocument.extended-properties+xml"/></Types>'
    $rootRelsXml = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="xl/workbook.xml"/><Relationship Id="rId2" Type="http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties" Target="docProps/core.xml"/><Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/extended-properties" Target="docProps/app.xml"/></Relationships>'
    $created = (Get-Date).ToUniversalTime().ToString('s') + 'Z'
    $coreXml = @"
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:dcmitype="http://purl.org/dc/dcmitype/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><dc:creator>GitHub Copilot</dc:creator><cp:lastModifiedBy>GitHub Copilot</cp:lastModifiedBy><dcterms:created xsi:type="dcterms:W3CDTF">$created</dcterms:created><dcterms:modified xsi:type="dcterms:W3CDTF">$created</dcterms:modified></cp:coreProperties>
"@
    $appXml = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Properties xmlns="http://schemas.openxmlformats.org/officeDocument/2006/extended-properties" xmlns:vt="http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes"><Application>GitHub Copilot</Application></Properties>'

    if (Test-Path -Path $OutputPath) {
        Remove-Item -Path $OutputPath -Force
    }

    $archive = [System.IO.Compression.ZipFile]::Open($OutputPath, [System.IO.Compression.ZipArchiveMode]::Create)
    try {
        $entries = @(
            @{ Path = '[Content_Types].xml'; Content = $contentTypesXml },
            @{ Path = '_rels/.rels'; Content = $rootRelsXml },
            @{ Path = 'docProps/core.xml'; Content = $coreXml },
            @{ Path = 'docProps/app.xml'; Content = $appXml },
            @{ Path = 'xl/workbook.xml'; Content = $workbookXml },
            @{ Path = 'xl/_rels/workbook.xml.rels'; Content = $workbookRelsXml },
            @{ Path = 'xl/worksheets/sheet1.xml'; Content = $worksheetXml },
            @{ Path = 'xl/styles.xml'; Content = $stylesXml }
        )

        foreach ($entry in $entries) {
            $zipEntry = $archive.CreateEntry($entry.Path)
            $stream = $zipEntry.Open()
            $writer = New-Object System.IO.StreamWriter($stream, [System.Text.Encoding]::UTF8)
            $writer.Write($entry.Content)
            $writer.Dispose()
            $stream.Dispose()
        }
    }
    finally {
        $archive.Dispose()
    }
}

Add-Type -AssemblyName System.Drawing

$repoRoot = Get-RepoRoot
$sqlPath = Join-Path $repoRoot 'sql\zx_plant_demo_03_seed.sql'
$configPath = Join-Path $repoRoot 'ruoyi-admin\src\main\resources\application.yml'

if (-not $ProfilePath) {
    $ProfilePath = Get-ProfilePathFromConfig -ConfigPath $configPath
}

$plantRows = foreach ($row in Get-InsertRows -SqlPath $sqlPath -TableName 'zx_plant') {
    $fields = Split-SqlValues -Tuple $row
    [PSCustomObject]@{
        PlantId = [int](Unquote-SqlValue $fields[0])
        CategoryId = [int](Unquote-SqlValue $fields[1])
        PlantName = Unquote-SqlValue $fields[2]
        PlantCode = Unquote-SqlValue $fields[3]
        AliasName = Unquote-SqlValue $fields[4]
        CoverImage = Unquote-SqlValue $fields[5]
        PlantSummary = Unquote-SqlValue $fields[6]
        DifficultyLevel = Unquote-SqlValue $fields[7]
        PriceLevel = Unquote-SqlValue $fields[8]
        DisplayStatus = Unquote-SqlValue $fields[9]
        PetSafeFlag = Unquote-SqlValue $fields[10]
        PurifyFlag = Unquote-SqlValue $fields[11]
        AromaFlag = Unquote-SqlValue $fields[12]
        SuitableScene = Unquote-SqlValue $fields[13]
        SortNum = Unquote-SqlValue $fields[14]
        Remark = Unquote-SqlValue $fields[19]
    }
}

$tagRows = foreach ($row in Get-InsertRows -SqlPath $sqlPath -TableName 'zx_plant_tag') {
    $fields = Split-SqlValues -Tuple $row
    [PSCustomObject]@{
        TagId = Unquote-SqlValue $fields[0]
        TagName = Unquote-SqlValue $fields[1]
        TagCode = Unquote-SqlValue $fields[2]
        TagGroup = Unquote-SqlValue $fields[3]
        TagDesc = Unquote-SqlValue $fields[4]
        SortNum = Unquote-SqlValue $fields[5]
        Status = Unquote-SqlValue $fields[6]
        Remark = Unquote-SqlValue $fields[10]
    }
}

$articleRows = foreach ($row in Get-InsertRows -SqlPath $sqlPath -TableName 'zx_content_article') {
    $fields = Split-SqlValues -Tuple $row
    [PSCustomObject]@{
        ArticleId = [int](Unquote-SqlValue $fields[0])
        ArticleType = Unquote-SqlValue $fields[1]
        Title = Unquote-SqlValue $fields[2]
        CoverImage = Unquote-SqlValue $fields[3]
        Summary = Unquote-SqlValue $fields[4]
        RelatedPlantId = Unquote-SqlValue $fields[6]
    }
}

$plantDir = Join-Path $ProfilePath 'upload\plant'
$articleDir = Join-Path $ProfilePath 'upload\article'
$importDir = Join-Path $ProfilePath 'upload\import'
Ensure-Directory -Path $plantDir
Ensure-Directory -Path $articleDir
Ensure-Directory -Path $importDir

$index = 0
foreach ($plant in $plantRows) {
    $detail = "Scene: $($plant.SuitableScene)  |  Difficulty: $($plant.DifficultyLevel)  |  Price: $($plant.PriceLevel)"
    $outputPath = Get-TargetPath -RootPath $ProfilePath -ResourcePath $plant.CoverImage
    New-DemoCover -OutputPath $outputPath -Badge 'PLANT' -Title $plant.PlantName -Subtitle $plant.AliasName -Detail $detail -Index $index -ForceWrite:$Force
    $index++
}

$articleIndex = 100
foreach ($article in $articleRows) {
    $detail = "Related plant: $($article.RelatedPlantId)  |  Type: $($article.ArticleType)"
    $outputPath = Get-TargetPath -RootPath $ProfilePath -ResourcePath $article.CoverImage
    New-DemoCover -OutputPath $outputPath -Badge 'ARTICLE' -Title $article.Title -Subtitle $article.Summary -Detail $detail -Index $articleIndex -ForceWrite:$Force
    $articleIndex++
}

$plantHeaders = @(
    @{ Title = 'plant_id' },
    @{ Title = 'category_id' },
    @{ Title = 'plant_name' },
    @{ Title = 'plant_code' },
    @{ Title = 'alias_name' },
    @{ Title = 'cover_image' },
    @{ Title = 'plant_summary' },
    @{ Title = 'difficulty_level' },
    @{ Title = 'price_level' },
    @{ Title = 'display_status' },
    @{ Title = 'pet_safe_flag' },
    @{ Title = 'purify_flag' },
    @{ Title = 'aroma_flag' },
    @{ Title = 'suitable_scene' },
    @{ Title = 'sort_num' },
    @{ Title = 'remark' }
)

$plantWorkbookRows = foreach ($plant in $plantRows) {
    ,@(
        $plant.PlantId,
        $plant.CategoryId,
        $plant.PlantName,
        $plant.PlantCode,
        $plant.AliasName,
        $plant.CoverImage,
        $plant.PlantSummary,
        $plant.DifficultyLevel,
        $plant.PriceLevel,
        $plant.DisplayStatus,
        $plant.PetSafeFlag,
        $plant.PurifyFlag,
        $plant.AromaFlag,
        $plant.SuitableScene,
        $plant.SortNum,
        $plant.Remark
    )
}

$tagHeaders = @(
    @{ Title = 'tag_id' },
    @{ Title = 'tag_name' },
    @{ Title = 'tag_code' },
    @{ Title = 'tag_group' },
    @{ Title = 'tag_desc' },
    @{ Title = 'sort_num' },
    @{ Title = 'status' },
    @{ Title = 'remark' }
)

$tagWorkbookRows = foreach ($tag in $tagRows) {
    ,@(
        $tag.TagId,
        $tag.TagName,
        $tag.TagCode,
        $tag.TagGroup,
        $tag.TagDesc,
        $tag.SortNum,
        $tag.Status,
        $tag.Remark
    )
}

New-XlsxFile -OutputPath (Join-Path $importDir 'plant_basic_demo.xlsx') -SheetName 'plant_basic' -Headers $plantHeaders -Rows $plantWorkbookRows -ForceWrite:$Force
New-XlsxFile -OutputPath (Join-Path $importDir 'plant_tag_demo.xlsx') -SheetName 'plant_tag' -Headers $tagHeaders -Rows $tagWorkbookRows -ForceWrite:$Force

$createdResources = @()
$createdResources += Get-ChildItem -Path $plantDir | Sort-Object Name | Select-Object Name, Length, LastWriteTime
$createdResources += Get-ChildItem -Path $articleDir | Sort-Object Name | Select-Object Name, Length, LastWriteTime
$createdResources += Get-ChildItem -Path $importDir | Sort-Object Name | Select-Object Name, Length, LastWriteTime

$createdResources | Format-Table -AutoSize | Out-String