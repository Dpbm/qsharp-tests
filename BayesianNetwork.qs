namespace BayesianNetworkTest {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Diagnostics;

    @EntryPoint()
    operation main() : Unit {
        Message("In this example, we'll use a Bayesian Network for DNA Nucleotides");
        Message("The idea here is that, the first Nucleotide has 60% likelihood of being G and 40% of being C");
        Message("Once we know that, the next one has 30% o chance of being A and 70% of being T if the previous one was G");
        Message("Otherwise it has 25% of chance of being C and 75% of being A");

        let netResults = RunNetwork();

        Message($"Network results: {netResults}");

        let decodedResults = decodeResults(netResults);

        Message($"Decoded results: {decodedResults}");

    }

    operation RunNetwork() : Result[] {
        use qubits = Qubit[2];

        let theta_1 = 2.0 * ArcCos(Sqrt(0.6));
        let theta_2 = 2.0 * ArcCos(Sqrt(0.3));
        let theta_3 = 2.0 * ArcCos(Sqrt(0.25));

        Message($"Once we want 60% of chance of being 0(G) and 40% of being 1(C), we can set θ angle as: {theta_1} ");

        Ry(theta_1, qubits[1]);
        DumpMachine();

        Message($"After that we want 30% o chance of being A(0) and 70% of being T(1) if the previous one was G(0): {theta_2} ");

        X(qubits[1]);
        Controlled Ry([qubits[1]], (theta_2, qubits[0]));
        X(qubits[1]);
        DumpMachine();

        Message($"Finally, the if the first qubit was C(1), we have 25% of chance of being C(0) and 75% of being A(1): {theta_3} ");

        Controlled Ry([qubits[1]], (theta_3, qubits[0]));
        DumpMachine();

        let results = MeasureEachZ(qubits);
        ResetAll(qubits);

        return results;
    }


    function decodeResults(results : Result[]) : String {
        mutable DNA = "";

        if (results[1] == Zero) {
            set DNA += "G";

            if (results[0] == Zero) {
                set DNA += "A";
            } else {
                set DNA += "T";
            }

        } else {
            set DNA += "C";

            if (results[0] == Zero) {
                set DNA += "C";
            } else {
                set DNA += "A";
            }
        }

        return DNA;
    }
}