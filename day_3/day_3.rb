input = '467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..'
=begin
Regle 
Pour qu'un nombre soit pris en compte : 
1 - sur même ligne qu'un symbole (sauf le .) n+1 ou n-1
2 - sur même colone n+1 ou n-1
3 diagonalement ( déplacement 1 en haut 1 sur le cote )
=end
#/\d/ => regex pour check si number
#/([!@#$%^&*()_+{}|:">?<\[\]\\\/';,`~])/ => regex pour check si symbole

=begin
Idée : 
par line => check si symbole et get leur index 
puis check every mouvment from symbole to check if number and check if that number > 10 => ajout dans une tableau ?
=end

def formatInput(input)
    inputFormatted = []
    input.split("\n").each_with_index do |line, lineIndex|
        inputFormatted.push(line.split(""))
    end
    return inputFormatted
end

matrice = formatInput(input)
matrice.each do |line|
    print line.join("")
    print "
"
end