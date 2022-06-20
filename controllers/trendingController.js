import { trendingRepository } from "../repositories/trendingRepository.js"

export async function getTrendings(req, res) {
  const LIMIT_TRENDINGS = 10

  try {
    const { rows: trendings } = await trendingRepository.getTrendingHashtags(
      LIMIT_TRENDINGS,
    )

    res.send(trendings)
  } catch (err) {
    return res.status(500).send(err.message)
  }
}
