# StackListCell

Create cells designed similarly to the Settings app, with support for Dynamic Types.
*Currently does not work in SwiftUI Previews

## Usage
```swift
StackListCell {
    Text("Camera")
} detail: {
    Text("Camera")
} image: {
    Image(systemName: "camera.fill")
}
```

```swift
StackListCell(.horizontal, title: "Car", detail: "car", systemImage: "car.fill")
  .tint(.cyan)
```

```swift
StackListCell(.vertical, title: "Home", detail: "house", systemImage: "house.fill")
  .tint(.red)
```

## Image
<img src="https://github.com/yidev0/StackListCell/blob/main/Sources/StackListCell/SampleImage.png" alt="Screenshot of StackListCell inside a List" width="400" />
