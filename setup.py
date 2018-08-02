from Cython.Distutils import build_ext
import numpy as np
from distutils.core import setup
from distutils.extension import Extension

numpy_include = np.get_include()


ext_modules = [
    Extension(
        'integral',
        sources=['integral.pyx'],
        include_dirs=[numpy_include]
    ),
    # Extension(
    #     'cython_nms',
    #     sources=['cython_nms.c'],
    #     include_dirs=[numpy_include]
    # )
]
setup(
    cmdclass={'build_ext': build_ext},
    ext_modules=ext_modules
)
#######################
# 在命令行输入python setup.py build_ext --inplace即可