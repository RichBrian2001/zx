import articleCoverFallback from '@/assets/plant/fallbacks/article-cover.svg'
import plantCoverFallback from '@/assets/plant/fallbacks/plant-cover.svg'

const baseApi = (process.env.VUE_APP_BASE_API || '').replace(/\/$/, '')

function resolveCoverUrl(coverImage) {
  if (!coverImage) {
    return ''
  }
  if (/^(https?:)?\/\//.test(coverImage)) {
    return coverImage
  }
  return `${baseApi}${coverImage}`
}

function buildCoverStyle(coverImage, fallbackImage, overlay) {
  const layers = []
  if (overlay) {
    layers.push(overlay)
  }
  if (coverImage) {
    layers.push(`url("${resolveCoverUrl(coverImage)}")`)
  }
  layers.push(`url("${fallbackImage}")`)
  return {
    backgroundImage: layers.join(', '),
    backgroundPosition: 'center',
    backgroundRepeat: 'no-repeat',
    backgroundSize: 'cover'
  }
}

export function getPlantCoverStyle(coverImage) {
  return buildCoverStyle(coverImage, plantCoverFallback, 'linear-gradient(180deg, rgba(28, 50, 30, 0.04), rgba(28, 50, 30, 0.2))')
}

export function getArticleCoverStyle(coverImage) {
  return buildCoverStyle(coverImage, articleCoverFallback, 'linear-gradient(180deg, rgba(28, 50, 30, 0.03), rgba(28, 50, 30, 0.16))')
}