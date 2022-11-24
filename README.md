A homebrew formula for IIO dependencies (Adalm-Pluto on Mac.)

### GNURadio 
Theoretically we should build the module with custom CMake like https://github.com/tfcollins/homebrew-formulae/blob/master/gr-iio.rb ,
but since the IIO module is now in tree, rebuilding GNURadio may be easier.

To install GNURadio with , use

```
brew tap xflash96/iio
brew install xflash96/homebrew-iio/gnuradio-with-iio
```

If conflicting with existing gnuradio installation:
```
brew link --overwrite gnuradio-with-iio
```

### SDRAngel
To install SDRAngel with IIO support (only), use
```
brew tap xflahs96/iio
brew install xflash96/homebrew-iio/sdrangel
```
The QT interface can be invoked with `sdrangel` command.
I disabled support for other devices to reduce dependencies. If you'd like to re-enable them, do
```
brew edit sdrangel
```
and modify the flags accordingly. There's also Mac-app option by `make package` (see ref).


### Reference
  - https://github.com/ttrftech/homebrew-adalm-pluto/blob/master/libad9361-iio.rb
  - https://github.com/tfcollins/homebrew-formulae/blob/master/gr-iio.rb
  - https://github.com/analogdevicesinc/libiio
  - https://github.com/f4exb/sdrangel/wiki/Compile-in-MacOS
