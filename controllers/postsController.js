import urlMetadata from "url-metadata"

import postsRepository from "../repositories/postsRepository.js"

import verboseConsoleLog from "../utils/verboseConsoleLog.js"

export async function getPosts(req, res) {
  const { limit, order, direction } = req.query

  try {
    const result = await postsRepository.getPosts(limit, order, direction)

    for (let i in result.rows) {
      const post = result.rows[i]
      try {
        const metadata = await urlMetadata(post.sharedUrl)

        post.previewTitle = metadata.title
        post.previewImage = metadata.image
        post.previewDescription = metadata.description
        post.previewUrl = metadata.url
      } catch (error) {
        console.log(error)
      }
    }

    return res.send(result.rows)
  } catch (error) {
    verboseConsoleLog("Error:", error)
    return res.sendStatus(500)
  }
}
