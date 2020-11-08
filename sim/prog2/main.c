int main() {

    extern int mul1;
    extern int mul2;
    extern long long _test_start;

    long long mul1_long = mul1;
    long long mul2_long = mul2;
    long long result = mul1_long * mul2_long;
    *(&_test_start) = result;
    
    return 0;
}