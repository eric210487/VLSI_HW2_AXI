int GCD(int a,int b)
{
 if( a == 0 || b == 0)return a+b;
 if( a&1 == 0 && b&1 == 0)return GCD(a>>1,b>>1)<<1;
 if( a&1 == 0)return GCD(a>>1,b);
 if( b&1 == 0)return GCD(a,b>>1);
 if( a>b )return GCD(b,a-b);
 return GCD(a,b-a);
}

int main(void) {
    extern int div1;
    extern int div2;
    extern int _test_start;

    *(&_test_start) = GCD(div1,div2);
        
    return 0;
}