require 'tk'
Dir.chdir(File.dirname(__FILE__))
puts Dir.pwd
root = TkRoot.new do
	title "Tictactoe in Ruby" 
	geometry "1200x800"
	background "#ffc901"
end

root.resizable(false, false)
root.minsize(1200, 800)
root.maxsize(1200, 800)

width = 1200
height = 100
colour = "#ffc901"

textbox = TkPhotoImage.new('width' => width, 'height' => height)
textbox.put(colour, 'to' => [0, 0, width, height])

img_burger = TkPhotoImage.new(:file => "Burger.png")
img_hdog = TkPhotoImage.new(:file => "hotdog.png")
img_None = TkPhotoImage.new(:file => "blankbutton.png")


placeholder = [" "," "," "," "," "," "," "," "," "]

txtbx = TkLabel.new do
	image textbox
	background colour
	grid("row" => 0, "column" => 0, "columnspan" => 3, "sticky" => "sw")
end


boxes = Array.new()

(0..2).each do |n|
	(0..2).each do |m|
		blanksp = TkLabel.new(root) do
			image img_None
			background colour
			grid("row" => (n+1), "column" => m)
		end
		boxes << blanksp
	end
end

def is_done (placeholder)
	if placeholder[0] == placeholder[1] && placeholder[0] == placeholder[2] && placeholder[0] != ' ' ||
		 placeholder[0] == placeholder[3] && placeholder[3] == placeholder[6] && placeholder[0] != ' ' ||
		 placeholder[1] == placeholder[4] && placeholder[4] == placeholder[7] && placeholder[1] != ' ' ||
		 placeholder[2] == placeholder[5] && placeholder[5] == placeholder[8] && placeholder[2] != ' ' ||
		 placeholder[3] == placeholder[4] && placeholder[3] == placeholder[5] && placeholder[3] != ' ' ||
		 placeholder[6] == placeholder[7] && placeholder[7] == placeholder[8] && placeholder[6] != ' ' ||
		 placeholder[0] == placeholder[4] && placeholder[0] == placeholder[8] && placeholder[0] != ' ' ||
		 placeholder[6] == placeholder[4] && placeholder[6] == placeholder[2] && placeholder[6] != ' ' ||
		 placeholder[0] != ' ' && placeholder[1] != ' ' && placeholder[2] != ' ' && placeholder[3] != ' ' &&
		 placeholder[4] != ' ' && placeholder[5] != ' ' && placeholder[6] != ' ' && placeholder[7] != ' ' &&
		 placeholder[8] != ' '
		return true
	else
		return false
	end
end
	
def winner (placeholder)
	if placeholder[0] == placeholder[1] && placeholder[0] == placeholder[2] && placeholder[0] != ' '
		winner = placeholder[0]
	elsif placeholder[1] == placeholder[4] && placeholder[7] == placeholder[4] && placeholder[1] != ' '
		winner = placeholder[1]
	elsif placeholder[0] == placeholder[3] && placeholder[3] == placeholder[6] && placeholder[0] != ' '
		winner = placeholder[0]
	elsif placeholder[2] == placeholder[5] && placeholder[5] == placeholder[8] && placeholder[2] != ' '
		winner = placeholder[2]
	elsif placeholder[3] == placeholder[4] && placeholder[3] == placeholder[5] && placeholder[3] != ' '
		winner = placeholder[3]
	elsif placeholder[6] == placeholder[7] && placeholder[7] == placeholder[8] && placeholder[6] != ' '
		winner = placeholder[6]
	elsif placeholder[0] == placeholder[4] && placeholder[0] == placeholder[8] && placeholder[0] != ' '
		winner = placeholder[0]
	elsif placeholder[6] == placeholder[4] && placeholder[6] == placeholder[2] && placeholder[6] != ' '
		winner = placeholder[6]
	else
		winner = 't'
	end
	return winner
end

@rwin = false
def boxcheck(placeholder, root, img_burger, img_hdog, count = -1, textbox)
	whoseturn = -1
	placeholder.each do |item|
		count += 1
		if item != " "
			whoseturn += 1
		end

		if item == "x"
			#puts "burger", count/3+1, count%3
			burger = TkLabel.new(root) do
				background "#b34b34"
				image img_burger
				grid("row" => count/3+1, "column" => count%3)
			end
		elsif item == "o"
			#puts "hotdog", count/3+1, count%3
			hotdog = TkLabel.new(root) do
				background "#b34b34"
				image img_hdog
				grid("row" => count/3+1, "column" => count%3)
			end
		end
	end

	font = TkFont.new("family" =>"Helvetica", "size" => 40, "weight" => "bold")
	if whoseturn % 2 == 1 && !is_done(placeholder)
		puts "B"
		txtbx = TkLabel.new do
			image textbox
			background "#ffc901"
			grid("row" => 0, "column" => 0, "columnspan" => 3, "sticky" => "sw")
		end
		txt = TkLabel.new do
			text "It is Burger's Turn"
			background "#ffc901"
			font font
			grid("row" => 0, "column" => 1)
		end
	elsif whoseturn % 2 == 0 && !is_done(placeholder)
		puts "HD"
		font = TkFont.new("family" =>"Helvetica", "size" => 40, "weight" => "bold")
		txtbx = TkLabel.new do
			image textbox
			background "#ffc901"
			grid("row" => 0, "column" => 0, "columnspan" => 3, "sticky" => "sw")
		end
		txt = TkLabel.new do
			text "It is Hot Dog's Turn"
			background "#ffc901"
			font font
			grid("row" => 0, "column" => 1)
		end
	elsif is_done(placeholder)
		if winner(placeholder) == "t"
			txtbx = TkLabel.new do
				image textbox
				background "#ffc901"
				grid("row" => 0, "column" => 0, "columnspan" => 3, "sticky" => "sw")
			end
			txt = TkLabel.new do
				text "Tie"
				background "#ffc901"
				font font
				grid("row"=>0, "column"=> 1)
			end
		elsif winner(placeholder) == "o"
			txtbx = TkLabel.new do
				image textbox
				background "#ffc901"
				grid("row" => 0, "column" => 0, "columnspan" => 3, "sticky" => "sw")
			end
			txt = TkLabel.new do
				text "Hot Dog Won!"
				background "#ffc901"
				font font
				grid("row"=>0, "column"=> 1)
			end
		else
			txtbx = TkLabel.new do
				image textbox
				background "#ffc901"
				grid("row" => 0, "column" => 0, "columnspan" => 3, "sticky" => "sw")
			end
			txt = TkLabel.new do
				text "Burger Won!"
				background "#ffc901"
				font font
				grid("row"=>0, "column"=> 1)
			end
		end
		
		if @rwin == false
			@rwin = true
		end
	end

	Tk.after(50){boxcheck(placeholder, root, img_burger, img_hdog, textbox)}
end

@placeholder = Array.new(9, " ")
@turn = 0
def clickcheck(boxes,placeholder)
	if !is_done(placeholder)
		print("a")
		boxes[0].bind("1") do
			if !is_done(placeholder)
				puts "box 1"
				if @turn % 2 == 0 && placeholder[0] == " "
					placeholder[0] = "x"
					@turn += 1
					puts placeholder.class
				elsif @turn % 2 == 1 && placeholder[0] == " "
					placeholder[0] = "o"
					@turn += 1
					puts placeholder.class
					 
				end
			end
		end
		boxes[1].bind("1") do
			if !is_done(placeholder)
				puts "box 2"
				if @turn % 2 == 0 && placeholder[1] == " "
					placeholder[1] = "x"
					@turn += 1
					 
					 
				elsif @turn % 2 == 1 && placeholder[1] == " "
					placeholder[1] = "o"
					@turn += 1
					 
					 
				end
			end
		end
		boxes[2].bind("1") do
			if !is_done(placeholder)
				if @turn % 2 == 0 && placeholder[2] == " "
					placeholder[2] = "x"
					@turn += 1
					 
					 
				elsif @turn % 2 == 1 && placeholder[2] == " "
					placeholder[2] = "o"
					@turn += 1
					 
					 
				end
			end
		end
		boxes[3].bind("1") do
			if !is_done(placeholder)
				puts "box 4"
				if @turn % 2 == 0 && placeholder[3] == " "
					placeholder[3] = "x"
					@turn += 1
					 
					 
				elsif @turn % 2 == 1 && placeholder[3] == " "
					placeholder[3] = "o"
					@turn += 1
					 
					 
				end
			end
		end
		boxes[4].bind("1") do
			if !is_done(placeholder)
				puts "box 5"
				if @turn % 2 == 0 && placeholder[4] == " "
					placeholder[4] = "x"
					@turn += 1
					 
					 
				elsif @turn % 2 == 1 && placeholder[4] == " "
					placeholder[4] = "o"
					@turn += 1
					 
					 
				end
			end
		end
		boxes[5].bind("1") do
			if !is_done(placeholder)
				puts "box 6"
				if @turn % 2 == 0 && placeholder[5] == " "
					placeholder[5] = "x"
					puts placeholder
					 
					@turn += 1
					 
				elsif @turn % 2 == 1 && placeholder[5] == " "
					placeholder[5] = "o"
					@turn += 1
					 
					 
				end
			end
		end
		boxes[6].bind("1") do
			if !is_done(placeholder)
				puts "box 7"
				if @turn % 2 == 0 && placeholder[6] == " "
					placeholder[6] = "x"
					@turn += 1
					 
					 
				elsif @turn % 2 == 1 && placeholder[6] == " "
					placeholder[6] = "o"
					@turn += 1
					 
					 
				end
			end
		end
		boxes[7].bind("1") do
			if !is_done(placeholder)
				puts "box 8"
				if @turn % 2 == 0 && placeholder[7] == " "
					placeholder[7] = "x"
					@turn += 1
					 
					 
				elsif @turn % 2 == 1 && placeholder[7] == " "
					placeholder[7] = "o"
					@turn += 1
					 
					 
				end
			end
		end
		boxes[8].bind("1") do
			if !is_done(placeholder)
				puts "box 9"
				if @turn % 2 == 0 && placeholder[8] == " "
					placeholder[8] = "x"
					@turn += 1
					 
					 
				elsif @turn % 2 == 1 && placeholder[8] == " "
					placeholder[8] = "o"
					@turn += 1
					 
				 
				end
			end
		end
	end
	@placeholder = placeholder
	Tk.after(50) {clickcheck(boxes,placeholder)}
end

def repwindow(root)
	playagain = TkToplevel.new(root) do
		title "play again?"
		background "#ffc901"
		geometry "500x300"
	end
	
	width = 250
	height = 265
	colour = "#ffc901"

	empty = TkPhotoImage.new('width' => width, 'height' => height)
	empty.put(colour, 'to' => [0, 0, width, height])
	

	font = TkFont.new("family" =>"Helvetica", "size" => 35, "weight" => "bold")
	TkLabel.new(playagain) do
		background "#ffc901"
		text "    Want to Play Again?"
		font font
		grid("row"=>0,"column"=>0,"columnspan"=>2,"sticky"=>"n")

	end
	
	
	emptybx = TkLabel.new(playagain) do
		image empty
		background colour
		grid("row" => 1, "column" => 0, "sticky" => "sw")
	end
	emptybx2 = TkLabel.new(playagain) do
		image empty
		background colour
		grid("row" => 1, "column" => 1, "sticky" => "sw")
	end

	TkButton.new(playagain) do
		text "No"
		font font
		background colour
		grid("row"=>1,"column"=>0, "sticky"=>"nsew")
		command do
			repwindow(root).destroy
			root.destroy
		end
	end
	
	TkButton.new(playagain) do
		text "Yes"
		font font
		background colour
		grid("row"=>1,"column"=>1, "sticky"=>"nsew")
		command do
			repwindow(root).destroy
			root.destroy
			exec("ruby #{$PROGRAM_NAME}")
		end
	end
		
end

def checkforwindow(root)
	if @rwin == true
		puts "HELLO"
		repwindow(root)
		@rwin = "abcd"
	end
end

def keepchecking(root)
	if @rwin == true
		checkforwindow(root)
	end
	Tk.after(1000) {keepchecking(root)}
end
	
Tk.after(50) do
	placeholder = clickcheck(boxes,placeholder)
	puts @placeholder.class
	boxcheck(@placeholder, root, img_burger, img_hdog, textbox)
	keepchecking(root)
end
	
Tk.mainloop

