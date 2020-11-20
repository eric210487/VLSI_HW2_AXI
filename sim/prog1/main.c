int main(void) {

    extern int array_size;
    extern int array_addr[];
    extern int _test_start;
    int temp;

    for(int i = 0; i < array_size; i++) {
        for(int j = 0; j < array_size - 1; j++) {
            if(array_addr[j] > array_addr[j+1]){
                temp = array_addr[j];
                array_addr[j] = array_addr[j+1];
                array_addr[j+1] = temp;
            }
        }
    }

    for(int i = 0; i < array_size; i++) {
        *(&_test_start + i) = array_addr[i];
    }

    return 0;
}
//#include <stdio.h>
/*
int F(int n)
{
 if(n<2) return 1;
 return F(n-1)+F(n-2);
}
int main()
{
 extern int _test_start;
 for(int i = 0; i < 10; i++) {
        *(&_test_start+i) = F(i);
    }
 return 0;
}*/