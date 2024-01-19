import gleam/http.{Get, Post}
import wisp.{type Request, type Response}
import gleam/string_builder
import app/web

/// The HTTP request handler- your application!
/// 
pub fn handle_request(req: Request) -> Response {
  // Apply the middleware stack for this request/response.
  use req <- web.middleware(req)

  // Later we'll use templates, but for now a string will do.

  case req.method {
    Get -> show_button()
    Post -> handle_form_submission(req)
    _ -> wisp.method_not_allowed(allowed: [Get, Post])
  }
  // Return a 200 OK response with the body and a HTML content type.
}

fn show_button() -> Response {
  let html =
    string_builder.from_string(
      "
<form method='post'>
  <button>ping :purple_heart:</button>
</form>
",
    )
  wisp.ok()
  |> wisp.html_body(html)
}

fn handle_form_submission(req: Request) -> Response {
  // not really using formdata at the moment
  use formdata <- wisp.require_form(req)
  show_button()
}
