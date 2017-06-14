from ipykernel.kernelapp import IPKernelApp
from .kernel import CafKernel
IPKernelApp.launch_instance(kernel_class=CafKernel)
