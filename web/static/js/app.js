import "phoenix_html"

import "timeago"
import "bootstrap"

$(document).ready(() => {
  $('[data-toggle="dropdown"]').dropdown()
  $("time.timeago").timeago();
})
