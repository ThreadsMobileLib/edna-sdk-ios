# SQFileViewer

Class which provides viewing other files with url.
Supported formats:
* iWork documents
* Microsoft Office documents (Office ‘97 and newer)
* Rich Text Format (RTF) documents
* PDF files
* Images
* Text files whose uniform type identifier (UTI) conforms to the public.text type (see Uniform Type Identifiers Reference)
* Comma-separated value (csv) files

## Requirements

iOS 8+

## Usage

### Implement `SQPhotoPicker` podspec
```ruby
pod 'SQUtils/SQPhotoPicker', :git => 'https://github.com/sequenia/SQUtils.git'
```

### Import `SQAttachment` protocol
```obj-c
#import "SQAttachment.h"
```

### Implement `SQAttachment` protocol for your data class (`Data` in my case) in the header file 
```obj-c
@interface Data (SQAttachment) <SQAttachment>
@end
```

### Realize `SQAttachment` protocol methods in the `.m`-file 
- Put this code:
```obj-c
@implementation Data (SQAttachment)
```
- Realize `fileUrl`-method which returned link to your file (`self.link` in my case)
```obj-c
- (NSURL *) fileUrl {
    return [NSURL URLWithString:self.link];
}
```

- Realize `fileName`-method which returned name of your file (`self.name` in my case)
```obj-c
- (NSString *) fileName {
    return self.name;
}
```

- Realize setter method for fileUrl-property. Don't ask me how it works. Just copy and paste code to your class :D
```obj-c
- (void) setFileUrl:(NSURL *)url {
    _link = url.absoluteString;
}
```

### Import `SQFileViewer` class to your controller

- Import `SQFileViewer` class
```obj-c
#import "SQFileViewer.h"
```
- Set property
```obj-c
@property SQFileViewer *fileViewer;
```

- And realize getter for this `fileViewer`. If you will set `SQFileViewerDelegate` delegate, you can setting progress of loading independently. Else `SQFileViewer` will show alert with progress label and cancel button.
```obj-c
- (SQFileViewer *) fileViewer {
    if (!_fileViewer){
        _fileViewer = [SQFileViewer fileViewerWithFileAttachments:array
                                                         delegate:nil];
    }
    return _fileViewer;
}
```

> :warning: NOTE: `array` is the NSArray of `id<SQAttachment>` objects


- Controlling of file downloading progress
```obj-c
- (void) fileDownloadedBy:(CGFloat)progress {
    //set progress independently
    self.progressView.progress = progress; //for example
}
```

### And last step
```obj-c
	[self.fileViewer openFileAt://index of your file
                     controller:self
                     completion:^(UIViewController *fileViewerController, NSError *error) {
                         if (!error && fileViewerController){
                             [self presentViewController: fileViewerController
                                                animated: YES
                                              completion: nil];
                         } else {
                             if (error.code != kCFURLErrorCancelled){
                                 NSLog(@"error = %@", error.localizedDescription);
                             }
                         }
                     }];
```

## Author
 Nikolay Kagala

## Contacts

* wolferineaz, tabriz@sequenia.com
* sequenia, sequenia@sequenia.com
