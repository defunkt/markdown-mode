set terminal png transparent size 640,240
set size 1.0,1.0

set terminal png transparent size 640,480
set output 'commits_by_author.png'
set key left top
set xdata time
set timefmt "%s"
set format x "%Y-%m-%d"
set grid y
set ylabel "Commits"
set xtics rotate
set bmargin 6
plot 'commits_by_author.dat' using 1:2 title "Jason Blevins" w lines, 'commits_by_author.dat' using 1:3 title "Matthias Ihrke" w lines, 'commits_by_author.dat' using 1:4 title "intrigeri" w lines, 'commits_by_author.dat' using 1:5 title "Eric Merritt" w lines, 'commits_by_author.dat' using 1:6 title "Ankit Solanki" w lines, 'commits_by_author.dat' using 1:7 title "Peter Williams" w lines, 'commits_by_author.dat' using 1:8 title "Christopher J. Madsen" w lines, 'commits_by_author.dat' using 1:9 title "Tim Visher" w lines, 'commits_by_author.dat' using 1:10 title "Scott Pfister" w lines, 'commits_by_author.dat' using 1:11 title "Kevin Porter" w lines, 'commits_by_author.dat' using 1:12 title "Joost Kremers" w lines, 'commits_by_author.dat' using 1:13 title "George Ogata" w lines, 'commits_by_author.dat' using 1:14 title "Edward O'Connor" w lines
