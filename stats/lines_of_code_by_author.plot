set terminal png transparent size 640,240
set size 1.0,1.0

set terminal png transparent size 640,480
set output 'lines_of_code_by_author.png'
set key left top
set xdata time
set timefmt "%s"
set format x "%Y-%m-%d"
set grid y
set ylabel "Lines"
set xtics rotate
set bmargin 6
plot 'lines_of_code_by_author.dat' using 1:2 title "Jason Blevins" w lines, 'lines_of_code_by_author.dat' using 1:3 title "Matthias Ihrke" w lines, 'lines_of_code_by_author.dat' using 1:4 title "intrigeri" w lines, 'lines_of_code_by_author.dat' using 1:5 title "Eric Merritt" w lines, 'lines_of_code_by_author.dat' using 1:6 title "Ankit Solanki" w lines, 'lines_of_code_by_author.dat' using 1:7 title "Peter Williams" w lines, 'lines_of_code_by_author.dat' using 1:8 title "Christopher J. Madsen" w lines, 'lines_of_code_by_author.dat' using 1:9 title "Tim Visher" w lines, 'lines_of_code_by_author.dat' using 1:10 title "Scott Pfister" w lines, 'lines_of_code_by_author.dat' using 1:11 title "Kevin Porter" w lines, 'lines_of_code_by_author.dat' using 1:12 title "Joost Kremers" w lines, 'lines_of_code_by_author.dat' using 1:13 title "George Ogata" w lines, 'lines_of_code_by_author.dat' using 1:14 title "Edward O'Connor" w lines
