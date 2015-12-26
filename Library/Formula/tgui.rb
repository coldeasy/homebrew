class Tgui < Formula
  desc "GUI library for use with sfml"
  homepage "http://tgui.eu"
  url "https://github.com/texus/TGUI/archive/v0.6.9.tar.gz"
  sha256 "9bbde01e918e950e484d75b3eaeb0c77f38180865f3cfcb188a56e77a62db8bb"

  depends_on "cmake" => :build
  depends_on "sfml"

  devel do
    url "https://github.com/texus/TGUI/archive/v0.7-alpha2.tar.gz"
    sha256 "12da819d3e396a3d3369051e3b40eb1c8f660a13dd5648706235aa282f415e4a"
  end

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<-EOS.undent
      #include <TGUI/TGUI.hpp>
      int main()
      {
        sf::Text text;
        text.setString("Hello World");
        return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-std=c++1y", "-I#{include}", "-L#{lib}", "-L#{HOMEBREW_PREFIX}/lib", "-ltgui", "-lsfml-graphics", "-lsfml-system", "-lsfml-window", "-o", "test"
    system "./test"
  end
end