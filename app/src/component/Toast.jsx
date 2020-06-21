import * as React from "react"
import { useState, useEffect } from "react"
import Snackbar from "@material-ui/core/Snackbar"
import Alert from "@material-ui/lab/Alert"

const Toast = ({ cond, severity, msg }) => {
  const [open, setOpen] = useState(cond)
  useEffect(() => setOpen(cond), [cond])
  return cond ?
    <Snackbar
      open={open}
      onClose={() => setOpen(false)}
      anchorOrigin={{ vertical: 'top', horizontal: 'center' }}
      autoHideDuration={6000}>
      <Alert severity={severity}>{msg}</Alert>
    </Snackbar> : null
}

export default Toast