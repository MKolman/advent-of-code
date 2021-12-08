f <- file("stdin")
open(f)
result1 <- 0
result2 <- 0
while(length(line <- readLines(f,n=1)) > 0) {
  parts <- strsplit(line, ' [|] ')[[1]]
  part1 <- strsplit(parts[1], ' ')[[1]]
  part2 <- strsplit(parts[2], ' ')[[1]]
  # process line
  for (w in part2) {
      if (nchar(w) == 2 || nchar(w) == 3 || nchar(w) == 7 || nchar(w) == 4) {
          result1 <- result1 + 1
      }
  }

  m <- list()
  for (i in (1:10)) {
      m[[i]] = strsplit("abcdefgh", '')[[1]]
  }
  for (w in part1) {
      o = strsplit(w, '')[[1]]
      if (nchar(w) == 2) {
          m[[1]] = o
      }
      if (nchar(w) == 3) {
          m[[7]] = o
      }
      if (nchar(w) == 4) {
          m[[4]] = o
      }
      if (nchar(w) == 7) {
          m[[8]] = o
      }
  }
  for (w in part1) {
      o = strsplit(w, '')[[1]]
      if (nchar(w) == 5) {
          L = setdiff(m[[4]], m[[1]])
          if (length(intersect(o, L)) == 2) {
              m[[5]] = o
          } else if (length(intersect(o, m[[1]])) == 2) {
              m[[3]] = o
          } else {
              m[[2]] = o
          }
      } else if (nchar(w) == 6) {
          if (length(intersect(o, m[[1]])) == 1) {
              m[[6]] = o
          } else if (length(intersect(o, m[[4]])) == 4) {
              m[[9]] = o
          } else {
              m[[10]] = o
          }
      }
  }
  n = 0
  for (w in part2) {
      n = n * 10
      for (i in (1:10)) {
          if (setequal(strsplit(w, '')[[1]], m[[i]])) {
              n = n + i %% 10
          }
      }
  }
  result2 = result2 + n

}
print(result1)
print(result2)
