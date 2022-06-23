import shareRepository from "../repositories/shareRepository.js"

export async function sharePost(req, res) {
  try {
    const { userId } = res.locals
    const { id: postId } = req.params
    await shareRepository.insertRepost(userId, postId)
    res.sendStatus(201)
  } catch (e) {
    res.status(500).send(e.message)
  }
}

export async function deleteRepost(req, res) {
  try {
    const { userId } = res.locals
    const { id: postId } = req.params
    await shareRepository.deleteRepost(userId, postId)
    res.sendStatus(204)
  } catch (e) {
    res.status(500).send(e.message)
  }
}
