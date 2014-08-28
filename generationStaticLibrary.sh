cd ExSwift

xcrun swiftc -sdk $(xcrun --show-sdk-path --sdk macosx) ExSwift.swift Array.swift String.swift NSArray.swift Dictionary.swift Double.swift Float.swift Int.swift Range.swift Sequence.swift -emit-library -emit-module -module-name ExSwift -v -o ExSwift.dylib -module-link-name ExSwift

xcrun swiftc -sdk $(xcrun --show-sdk-path --sdk iphonesimulator) -c ExSwift.swift Array.swift String.swift NSArray.swift Dictionary.swift Double.swift Float.swift Int.swift Range.swift Sequence.swift -parse-as-library -module-name ExSwift -v -target x86_64-apple-darwin13.3.0
ar rvs ExSwift_sim64.a ExSwift.o Array.o Dictionary.o Double.o Float.o NSArray.o String.o Int.o Range.o Sequence.o

xcrun swiftc -sdk $(xcrun --show-sdk-path --sdk iphoneos) -c ExSwift.swift Array.swift String.swift NSArray.swift Dictionary.swift Double.swift Float.swift Int.swift Range.swift Sequence.swift -parse-as-library -module-name ExSwift -v -target armv7-apple-ios8
ar rvs ExSwift_armv7.a ExSwift.o Array.o Dictionary.o Double.o Float.o NSArray.o String.o Int.o Range.o Sequence.o

xcrun swiftc -sdk $(xcrun --show-sdk-path --sdk iphoneos) -c ExSwift.swift Array.swift String.swift NSArray.swift Dictionary.swift Double.swift Float.swift Int.swift Range.swift Sequence.swift -parse-as-library -module-name ExSwift -v -target armv7s-apple-ios8
ar rvs ExSwift_armv7s.a ExSwift.o Array.o Dictionary.o Double.o Float.o NSArray.o String.o Int.o Range.o Sequence.o

xcrun swiftc -sdk $(xcrun --show-sdk-path --sdk iphoneos) -c ExSwift.swift Array.swift String.swift NSArray.swift Dictionary.swift Double.swift Float.swift Int.swift Range.swift Sequence.swift -parse-as-library -module-name ExSwift -v -target arm64-apple-ios8
ar rvs ExSwift_arm64.a ExSwift.o Array.o Dictionary.o Double.o Float.o NSArray.o String.o Int.o Range.o Sequence.o

lipo -create ExSwift_sim64.a ExSwift_armv7.a ExSwift_armv7s.a ExSwift_arm64.a -output ExSwift.a

mkdir ../ExSwift.framework
mv ExSwift.swiftdoc ../ExSwift.framework
mv ExSwift.swiftmodule ../ExSwift.framework
mv ExSwift.a ../ExSwift.framework/ExSwift
chmod +x ../ExSwift.framework/ExSwift

rm ExSwift.dylib
rm *.o
rm *.a





