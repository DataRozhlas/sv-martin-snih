dsv = d3.dsv ";"
stations =
  "CHEB, EZ": "Cheb"
  "LIBEREC, EZ": "Liberec"
  "LYSA HORA, EZ": "Lysá hora"
  "MILESOVKA, EZ": "Milešovka"
  "MOSNOV, EZ": "Mošnov"
  "PRIBYSLAV, EZ": "Přibyslav"
  "PRIMDA, EZ": "Přimda"
  "RUZYNE, EZ": "Ruzyně"
  "TURANY, EZ": "Tuřany"
data = dsv.parse ig.data.data, (row) ->
  [year, month, day] = row.date.split "-" .map parseInt _, 10
  row.dateString = row.date
  row.date = new Date!
    ..setTime 0
    ..setFullYear year
    ..setMonth month - 1
    ..setDate day
  row.name = stations[row.station]
  row

comparisonDate = new Date!
  ..setTime 0
  ..setMonth 10
  ..setDate 11

leftSide = 5878800000

scaleX = (datum, index) ->
  comparisonDate.setFullYear datum.date.getFullYear!
  (leftSide + datum.date.getTime! - comparisonDate.getTime!) / leftSide * 100

# console.log do
#   d3.extent data.map scaleX

container = d3.select ig.containers.base
container.append \div
  ..attr \class \dotchart
  ..selectAll \div.year .data data .enter!append \div
    ..attr \class \year
    ..append \div
      ..attr \class \dot-bg
      ..style \left -> "#{scaleX ...}%"
    ..append \div
      ..attr \class \dot
      ..style \left -> "#{scaleX ...}%"
      ..append \div
        ..attr \class \label-year
        ..html ({date, name}) -> "<b>#{date.getFullYear!}:</b> #{date.getDate!}. #{date.getMonth! + 1}., #{name}"
  ..append \div
    ..attr \class \label-max
    ..html "11. 11.: Svatý Martin&nbsp;&nbsp;›"
