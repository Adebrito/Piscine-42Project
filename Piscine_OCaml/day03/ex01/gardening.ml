type 'a tree = Nil | Node of 'a * 'a tree * 'a tree

let rec size tree =
	match tree with
	| Nil -> 0
	| Node(c, l, r) -> (1 + (size l) + (size r))

let rec height tree =
	match tree with
	| Nil -> 0
	| Node(c, l, r) -> 1 + (max (height l) (height r))

let draw_square x y size str =
	Graphics.moveto (x - (size / 2)) (y - (size / 4));
	Graphics.lineto (x - (size / 2)) (y + (size / 4));
	Graphics.lineto (x + (size / 2)) (y + (size / 4));
	Graphics.lineto (x + (size / 2)) (y - (size / 4));
	Graphics.lineto (x - (size / 2)) (y - (size / 4));
	Graphics.moveto (x - (size / 4)) (y - 5);
	Graphics.draw_string str

let rec draw_tree ?(offset=0) node x y  = match node with
	| Nil -> draw_square x y 50 "Nil"
	| Node(t, c1, c2) ->
		begin
			draw_square x y 50 t;
			Graphics.moveto (x + 75) (y - (50 + offset));
			Graphics.lineto (x + 25) y;
			Graphics.lineto (x + 75) (y + (50 + offset));
			draw_tree ~offset:(offset/2) c1 (x + 100) (y - (50 + offset));
			draw_tree ~offset:(offset/2) c2 (x + 100) (y + (50 + offset));
		end

let main () =
	Graphics.open_graph " 800x600";
	let tree = Nil in
		draw_tree tree 50 100;
		Graphics.moveto 25 70; 
		Graphics.draw_string ("size: " ^ (string_of_int (size tree)));
		Graphics.moveto 25 55; 
		Graphics.draw_string ("height: " ^ (string_of_int (height tree)));

	let tree = (Node ("value", Nil, Nil)) in
		draw_tree tree 50 300;
		Graphics.moveto 25 270; 
		Graphics.draw_string ("size: " ^ (string_of_int (size tree)));
		Graphics.moveto 25 255; 
		Graphics.draw_string ("height: " ^ (string_of_int (height tree)));

	let tree = (Node ("echo", (Node("wall", Nil, Nil)), (Node("echo", (Node("wall", Nil, Nil)), Nil)))) in
		draw_tree ~offset:30 tree 250 300;
		Graphics.moveto 225 270; 
		Graphics.draw_string ("size: " ^ (string_of_int (size tree)));
		Graphics.moveto 225 255; 
		Graphics.draw_string ("height: " ^ (string_of_int (height tree)));
	Graphics.read_key ()

let _ = main ()