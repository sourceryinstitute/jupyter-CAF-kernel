from ipykernel.kernelapp import IPKernelApp
from .kernel import CAFKernel
IPKernelApp.launch_instance(kernel_class=CAFKernel)
