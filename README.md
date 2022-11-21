A homebrew wrapper to deal with the IIO dependencies in gnuradio (for using Adalm-Pluto on Mac.)
Theoretically we should build the module with custom CMake like https://github.com/tfcollins/homebrew-formulae/blob/master/gr-iio.rb ,
but since the IIO module is now in tree, rebuilding GNURadio may be easier.

To install, use

```
brew tap xflash96/homebrew-gnuradio-with-iio
brew install xflash96/homebrew-gnuradio-with-iio/gnuradio-with-iio
```

If conflicting with existing gnuradio installation:
```
brew link --overwrite gnuradio-with-iio
```

Reference:
  - https://github.com/ttrftech/homebrew-adalm-pluto/blob/master/libad9361-iio.rb
  - https://github.com/tfcollins/homebrew-formulae/blob/master/gr-iio.rb
  - https://github.com/analogdevicesinc/libiio
