ghdl --clean
ghdl --remove
ghdl -a "Eq12-PC.vhd"
ghdl -a "Eq12-PC_plus1.vhd"
ghdl -a "Eq12-PC_Top.vhd"
ghdl -a "Eq12-Rom.vhd"
ghdl -a "Eq12-Maq_Estados.vhd"
ghdl -a "Eq12-Un_controle.vhd"
ghdl -a "Eq12-reg20bits.vhd"
ghdl -a "Eq12-RegFile.vhd"
ghdl -a "Eq12-ULA.vhd"
ghdl -a "Eq12-Reg_ULA_Top.vhd"
ghdl -a "Eq12-ROM_PC_UC.vhd"
ghdl -a "Eq12-Proc_Top.vhd"
ghdl -a "Eq12-Prime_tb.vhd"
ghdl -r Eq12_Prime_tb --wave=Eq12-Calc.ghw --stop-time=150us