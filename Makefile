CFLAGS=-Wall -O2 -fopenmp -march=native -funroll-loops #-g -pg
LDLIBS=-lm
BIN=lbm

.PHONY: default plots data profile clean

default: plots

plots: data
	@cd out && for f in *.txt; do gnuplot -e "matrixfile='$$f'" plotmatrix.gp; done

data: $(BIN)
	@./$(BIN)

profile: clean $(BIN) data
	@gprof $(BIN) > $(BIN)-profile.txt
	@less $(BIN)-profile.txt

clean:
	@$(RM) $(BIN)
	@$(RM) *.o
	@$(RM) out/*.txt
	@$(RM) out/*.png
