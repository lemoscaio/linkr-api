import userRepository from "../repositories/userRepository.js"
import verboseConsoleLog from "../utils/verboseConsoleLog.js"

export async function getUser(req, res) {
  const { userId } = req.params

  try {
    const result = await userRepository.getUserById(userId)
    verboseConsoleLog("Result:", result.rows)
    return res.send(result.rows[0])
  } catch (error) {
    verboseConsoleLog("Error:", error)
    return res.sendStatus(500)
  }
}

export async function getUserByUsername(req, res) {
  const { username } = req.query

  try {
    const resultUsers = await userRepository.getUserByUsername(username)
    verboseConsoleLog("Result:", resultUsers.rows)
    return res.status(200).send(resultUsers.rows)
  } catch (error) {
    verboseConsoleLog("Error:", error)
    return res.status(500).send(error)
  }
}
