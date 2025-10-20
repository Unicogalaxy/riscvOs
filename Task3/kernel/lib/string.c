#include"../../include/types.h"


void*
memset(void *ptr, int c, uint n)
{
  char *cdst = (char *) ptr;
  int i;
  for(i = 0; i < n; i++){
    cdst[i] = c;
  }
  return ptr;
}