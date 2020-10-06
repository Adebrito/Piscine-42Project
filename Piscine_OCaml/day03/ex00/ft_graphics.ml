type 'a tree = Nil | Node of 'a * 'a tree * 'a tree

let draw_square x y size str =
	Graphics.moveto (x - (size / 2)) (y - (size / 4));
	Graphics.lineto (x - (size / 2)) (y + (size / 4));
	Graphics.lineto (x + (size / 2)) (y + (size / 4));
	Graphics.lineto (x + (size / 2)) (y - (size / 4));
	Graphics.lineto (x - (size / 2)) (y - (size / 4));
	Graphics.moveto (x - (size / 4)) (y - 5);
	Graphics.draw_string str

let rec draw_tree_node ?(offset=0) node x y  = match node with
	| Nil -> draw_square x y 50 "Nil"
	| Node(t, c1, c2) ->
		begin
			draw_square x y 50 t;
			Graphics.moveto (x + 75) (y - (50 + offset));
			Graphics.lineto (x + 25) y;
			Graphics.lineto (x + 75) (y + (50 + offset));
			draw_tree_node ~offset:(offset/2) c1 (x + 100) (y - (50 + offset));
			draw_tree_node ~offset:(offset/2) c2 (x + 100) (y + (50 + offset));
		end

let main () =
	Graphics.open_graph " 800x600";
	draw_tree_node Nil 50 100;
	draw_tree_node (Node ("value", Nil, Nil)) 50 300;
	draw_tree_node (Node ("echo", (Node("wall", Nil, Nil)), (Node("echo", (Node("wall", Nil, Nil)), Nil)))) ~offset:(40) 250 300;
	Graphics.read_key ()

let _ = main ()