import * as React from "react";
import * as ReactDOM from "react-dom";

import App from "./container/App";

const app = <React.Fragment>
  <App />
</React.Fragment>

ReactDOM.render(app, document.getElementById("index"));
