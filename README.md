# InstaZoom

Replicate easily the Instagram zooming feature on `UIImageView`.

### Usage

[Demo](http://i.imgur.com/9TMAz6f.gif)

#### Import
```swift
/// Swift
import InstaZoom
```

#### Use case

- To activate the zoom:
```swift
let imageView = UIImageView(image: yourImage)
imageView.isPinchable = true // Quite simple
```
- To disable it:
```swift
imageView.isPinchable = false
```
