input ='467..114..
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
1 - sur m�me ligne qu'un symbole (sauf le .) n+1 ou n-1
2 - sur m�me colone n+1 ou n-1
3 diagonalement ( d�placement 1 en haut 1 sur le cote )
=end
#/\d/ => regex pour check si number
#/([!@#$%^&*()_+{}|:">?<\[\]\\\/';,`~])/ => regex pour check si symbole

=begin
Id�e :
par line => check si symbole et get leur index
puis check every mouvment from symbole to check if number and check if that number > 10 => ajout dans une tableau ?
=end

class Char
    def initialize(indexLine, indexChar, char, isNumber, isSymbole)
        @indexLine = indexLine
        @indexChar = indexChar
        @char = char
        @isNumber = isNumber
        @isSymbole = isSymbole
    end
    def getIndex()
        return [@indexLine, @indexChar]
    end
    def lineIndex()
        @indexLine
    end
    def charIndex()
        @indexChar
    end
    def to_s
        @char.to_s
    end
    def getChar()
        @char
    end
end

def numberInLine
    def initialize(indexStart, indexEnd, number)
        @indexStart = indexStart
        @indexEnd = indexEnd
        @number = number
    end
    def setNumber(number)
        @number = number
    end
    def getNumber()
        @number
    end
    def getIndex()
        return [@indexStart, @indexEnd]
    end
end

class Line
    def initialize(index, chars)
        @index = index
        @chars = chars
    end
    def to_s
        @chars.join("")
    end
    def getChar(index)
        @chars[index]
    end
end

class Matrix
    def initialize(lines)
        @lines = lines
    end
    def printLines
        @lines.each do |line|
            print line.to_s
            print "
"
        end
    end
    def getLine(index)
        @lines[index]
    end
end

def formatInput(input)
    inputFormatted = []
    chars = []
    input.split("\n").each_with_index do |line, lineIndex|
        listChar = line.split("")
        inputFormatted.push(Line.new(lineIndex, listChar))
    end
    return Matrix.new(inputFormatted)
end

def searchSymbole(input)
    chars = []
    input.split("\n").each_with_index do |line, lineIndex|
        listChar = line.split("")
        listChar.each_with_index do |char, charIndex|
            if char.match(/([!@#$%^&*()_+{}|:">?<\[\]\\\/';,`~])/) then
                chars.push(Char.new(lineIndex, charIndex, char, false, true))
            end
        end
    end
    return chars
end
def searchNumber(input)
    chars = []
    input.split("\n").each_with_index do |line, lineIndex|
        listChar = line.split("")
        listChar.each_with_index do |char, charIndex|
            if char.match(/[0-9]/) then
                chars.push(Char.new(lineIndex, charIndex, char, true, false))
            end
        end
    end
    return chars
end

def findAllNumber(lineIndex, charIndex, matrice)
    #  a gauche . donc for vers la droite jusqu'a autre chose qu'un chiffre

    #  a droite . donc for vers la gauche jusqu'a autre chose qu'un chiffre
    #  a droite . et a droite donc for vers la gauche et la droite jusqu'a autre chose qu'un chiffre
    return matrice.getLine(lineIndex).getChar(charIndex)
end

def checkFunction(lineIndex, charIndex, matrice)
    #  [1,3] = [0,3]; [0,2];[0,4];[1,2];[1,4];[2,3]; [2,2];[2,4];
    line = matrice.getLine(lineIndex - 1)
    sameNumber = []
    for i in charIndex - 1..charIndex + 1 do
        if line.getChar(i).match(/[0-9]/) then
            if ( i >= charIndex && sameNumber.include?(line.getChar(i - 1))) then
                newNum = line.getChar(i - 1).to_s + line.getChar(i).to_s
                sameNumber = sameNumber.map { |x| x.num == line.getChar(i - 1) ? {num: newNum, indexStart: x.indexStart, indexEnd: i} : x }
            else
                sameNumber.push({num: line.getChar(i), indexStart: i, indexEnd: i})
            end
        end
    end
    line = matrice.getLine(lineIndex + 1)
    for i in charIndex - 1..charIndex + 1 do
        if line.getChar(i).match(/[0-9]/) then
            if ( i >= charIndex && sameNumber.include?(line.getChar(i - 1))) then
                newNum = line.getChar(i - 1).to_s + line.getChar(i).to_s
                sameNumber = sameNumber.map { |x| x.num == line.getChar(i - 1) ? {num: newNum, indexStart: x.indexStart, indexEnd: i} : x }
            else
                sameNumber.push({num: line.getChar(i), indexStart: i, indexEnd: i})
            end
        end
    end

    line = matrice.getLine(lineIndex)
    if line.getChar(charIndex - 1).match(/[0-9]/) then
        sameNumber.push({num: line.getChar(charIndex - 1), indexStart: charIndex - 1, indexEnd: charIndex - 1})
    end
    if line.getChar(charIndex + 1).match(/[0-9]/) then
        sameNumber.push({num: line.getChar(charIndex + 1), indexStart: charIndex + 1, indexEnd: charIndex + 1})
    end
    print sameNumber.select { |x| x == line.getChar(i - 1)}
    print "
    "
end

matrice = formatInput(input)
symboleInInput = searchSymbole(input)
numberInInput = searchNumber(input)

symboleInInput.each do |symbole|
    checkFunction(symbole.lineIndex, symbole.charIndex, matrice)
end
