import React, { useState } from "react"
import ReactDOM from "react-dom"

import Button from "react-bootstrap/Button"
import Stack from "react-bootstrap/Stack"
import Form from "react-bootstrap/Form"
import Alert from "react-bootstrap/Alert"
import Card from "react-bootstrap/Card"
import axios from "axios"
// Importing the Bootstrap CSS
import "bootstrap/dist/css/bootstrap.min.css"

const Index = () => {
  const [url, setUrl] = useState("")
  const [shortUrl, setShortUrl] = useState(null)
  const [show, setShow] = useState(false)
  const [isCopied, setIsCopied] = useState(false)

  async function copyTextToClipboard(text) {
    if ("clipboard" in navigator) {
      return await navigator.clipboard.writeText(text)
    } else {
      return document.execCommand("copy", true, text)
    }
  }

  const handleCopyClick = async () => {
    try {
      const res = await copyTextToClipboard(shortUrl)
      setIsCopied(true)
      setTimeout(() => {
        setIsCopied(false)
      }, 1500)
    } catch (err) {
      console.log(err)
    }
  }

  const handleSubmit = async () => {
    try {
      const res = await axios.post("/link", {
        url,
      })
      setShow(false)
      setShortUrl(res.data.short_url)
    } catch (err) {
      setShow(true)
    }
  }

  return (
    <div className="col-md-5 mx-auto mt-5">
      {show && (
        <Alert variant="danger" onClose={() => setShow(false)} dismissible>
          <p>Unable to shorten URL as link is invalid.</p>
        </Alert>
      )}

      <Stack direction="horizontal" gap={3}>
        <Form.Control
          onChange={(e) => {
            setUrl(e.target.value)
          }}
          value={url}
          className="me-auto"
          placeholder="Enter a URL to shorten"
          type="text"
        />
        <Button variant="primary" onClick={handleSubmit}>
          Submit
        </Button>
      </Stack>

      {shortUrl && (
        <Card className="text-center mt-3">
          <Card.Body>
            <Card.Text>
              <a href={shortUrl}>{shortUrl}</a>
            </Card.Text>
            <Button variant="primary" onClick={handleCopyClick}>
              {isCopied ? "Copied!" : "Copy"}
            </Button>
          </Card.Body>
        </Card>
      )}
    </div>
  )
}

document.addEventListener("DOMContentLoaded", () => {
  ReactDOM.render(
    <Index name="React" />,
    document.body.appendChild(document.createElement("div")),
  )
})
