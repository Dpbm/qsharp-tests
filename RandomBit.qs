namespace RandomBitTest {

    @EntryPoint()
    operation main() : Result {
        use q = Qubit();

        H(q);
        let result = M(q);
        Reset(q);
        return result;

    }
}