#include <stdio.h>
int main(){
int count=0,found=0;
int a=2,current=2;
while(found<100000){
    while(a<current)
    {
        if(current%a==0){
            count=1;
        }
        a++;
    }
    if(count==0){
        found++;
    }
    current++;
    a=2;
    count=0;
}
}
