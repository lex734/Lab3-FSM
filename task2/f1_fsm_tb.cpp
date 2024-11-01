#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vf1_fsm.h"

#include "vbuddy.cpp"
#define MAX_SIM_CYC 10000000

int main(int argc, char **argv, char **env) {
    int simcyc;
    int tick;

    Verilated::commandArgs(argc, argv);
    Vf1_fsm* top = new Vf1_fsm;
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("waveform.vcd");

    if (vbdOpen() != 1) {
        printf("FAIL");
        return -1;
    }
    vbdHeader("L3T2: F1 FSM");

    top->clk = 1;
    top->rst = 0; // Start with reset active
    top->en = 0;

    for (simcyc = 0; simcyc < MAX_SIM_CYC; simcyc++) {
        // Toggle clock
        for (tick = 0; tick < 2; tick++) {
            tfp->dump (2*simcyc+tick);
            top->clk = !top->clk;
            top->eval();
        }
        

        // Update enable signal based on vbuddy flag (if it changes dynamically)
        top->en = vbdFlag();
        vbdBar(top->data_out & 0xFF);
        
        // Check for user input to exit
        if (Verilated::gotFinish() || vbdGetkey() == 'q') {
            exit(0);
        }
    }

    // Cleanup
    vbdClose();
    tfp->close();
    printf("Exiting\n");
    exit(0);
}
