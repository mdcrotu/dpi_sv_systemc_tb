
#ifndef DPI_INTERFACE_H
#define DPI_INTERFACE_H

#ifdef __cplusplus
extern "C" {
#endif

void sc_model_init(int param);
void sc_model_drive(int val);
int  sc_model_get();

#ifdef __cplusplus
}
#endif

#endif // DPI_INTERFACE_H
