import React, { useState } from "react"
import Button from "react-bootstrap/Button"
import PropTypes from "prop-types"

const CopyButton = ({ text }) => {
  const [isCopied, setIsCopied] = useState(false)

  async function copyTextToClipboard() {
    if ("clipboard" in navigator) {
      return await navigator.clipboard.writeText(text)
    } else {
      // IE fallback
      return document.execCommand("copy", true, text)
    }
  }

  const handleCopyClick = async () => {
    try {
      await copyTextToClipboard()
      setIsCopied(true)
      setTimeout(() => {
        setIsCopied(false)
      }, 1500)
    } catch (err) {
      console.log(err)
    }
  }

  return (
    <Button variant="primary" onClick={handleCopyClick}>
      {isCopied ? "Copied!" : "Copy"}
    </Button>
  )
}

CopyButton.propTypes = {
  text: PropTypes.string.isRequired,
}

export default CopyButton
