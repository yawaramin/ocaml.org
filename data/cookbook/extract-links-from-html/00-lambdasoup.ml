---
packages:
- name: "lambdasoup"
  tested_version: "1.0.0"
  used_libraries:
  - lambdasoup
---

open Soup

(* `find_links html_content` prints out all hyperlinks found inside `href`
   attributes of `<a>` tags in the given HTML content. *)

let find_links html_content =
  (* `parse` parses a string containing HTML markup into a document node. *)
  let document_node = parse html_content in 

  (* `$$` selects all nodes in the document matching the selector query.

     `R.attribute` gets the value of an attribute from a node, raising an error
     if the attribute doesn't exist. In this case we know there won't be any
     error because we've already selected `<a>` tags which have the `href`
     attribute. *)
  document_node $$ "a[href]" |> iter (fun a -> print_endline (R.attribute "href" a))

(* Example usage *)

let html_content = {|
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sample HTML Page</title>
</head>
<body>
    <header>
        <h1>My Cool Learning Links</h1>
    </header>
    <main>
        <section>
            <h2>Click a link to get started!</h2>
            <ul>
                <li><a href="https://ocaml.org/docs">The Ocaml.org Learning Page</a></li>
                <li><a href="https://pola.rs/">Pola.rs: Modern Python Dataframes</a></li>
                <li><a href="https://www.nonexistentwebsite.com">It used to work.com</a></li>
            </ul>
        </section>
    </main>
</body>
</html>
|}

(* Expected output:

   https://ocaml.org/docs
   https://pola.rs/
   https://www.nonexistentwebsite.com *)
let () = find_links html_content

