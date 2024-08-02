namespace TeleportationTest {

    open Microsoft.Quantum.Diagnostics;

    @EntryPoint()
    operation main() : Unit {
        Message("----Teleportation Test----");
        Message("1. Initialized circuit");
        use alice = Qubit[2];
        use bob = Qubit();
        DumpMachine();


        Message("2. Entangled Bob's and Alice's first qubit");
        H(alice[1]);
        CNOT(alice[1], bob);
        DumpMachine();

        Message("3. Encode the message");
        X(alice[0]);
        H(alice[0]);
        DumpMachine();

        Message("4. Make a Bell measurement on the Alice's qubits");
        CNOT(alice[0], alice[1]);
        H(alice[0]);
        DumpMachine();

        let alice_results = MeasureEachZ(alice);
        Message($"results: {alice_results}");

        ResetAll(alice);

        if (alice_results[0] == One) {
            Z(bob);
        }

        if (alice_results[1] == One) {
            X(bob);
        }

        DumpMachine();


        Message("5. Measure Bob's qubit");
        //H(bob);
        DumpMachine();
        let bob_result = M(bob);
        Message($"Bob's result: {bob_result}");
        Reset(bob);

    }

}