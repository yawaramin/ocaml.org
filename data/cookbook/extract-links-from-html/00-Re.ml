---
packages:
  - name: "re"
    tested_version: "1.11.0"
    used_libraries:
      - re
---

(*

Given an HTML document or string, we can use the `re` library to create a regular expression that finds the `href` tags containing web links.
For example, in the sample below we would expect to find three links for this HTML document.

Sample HTML: 

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
            <H2>Click a link to get started!</H2>
            <ul>
                <li><a href="https://ocaml.org/docs">The Ocaml.org Learning Page</a></li>
                <li><a href="https://pola.rs/">Pola.rs: Modern Python Dataframes</a></li>
                <li><a href="https://www.nonexistentwebsite.com">It used to work.com</a></li>
            </ul>
        </section>
    </main>
</body>
</html>

`find_links` accepts an argument `html_content` of type string that contains our HTML content.

Use `Re.Perl.re` to create a Perl flavored regular expression that searches for the `a href` tags. You can view the pattern using [Regex101](https://regex101.com/r/2Bs442/1)
to understand more about what is going on. 

`Re.all` searches the entire `html_content` string for the `pattern`.

We then pipe the output to `List.map`, since `Re.all` returns a list of all matches and applies the `Re.group.get` function to each group
in the list. Passing `1` we get the substring versus the entire matching group. This way we only get the URL link and not the entire HTML tag.

`List.iter` iterates through the `links` list and prints the URLs.

*)
let find_links html_content = 
  let pattern = Re.compile (Re.Perl.re "<a[^>]* href=\"([^\"]*)") in
  let links = Re.all pattern html_content 
  |> List.map (fun group -> Re.Group.get group 1) in
  List.iter print_endline links


(*
Example usage:
First, define helper function `read_file` to read in HTML content at the path. Note: you may need to include `Open Stdlib` to access `In_channel`
*)
let read_file file = 
  In_channel.with_open_text file In_channel.input_all

  
(* Open the HTML file using `read_file` and find the links using the `find_links` function. *)
let () = find_links (read_file "lib/webhtml/index.html")
