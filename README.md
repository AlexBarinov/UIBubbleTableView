UIBubbleTableView is UITableView based iOS component for rendering chats like it's done in Messages application.

![Screenshow](https://github.com/AlexBarinov/UIBubbleTableView/readme/screenshot.png)

How to install
-

As easy as 1-2-3:

1. Download the source from [https://github.com/AlexBarinov/UIBubbleTableView.git](https://github.com/AlexBarinov/UIBubbleTableView.git)
2. Add the files under the `src`directory into your xCode project
3. Add `UIBubbleTableView` to your ViewController and implement `UIBubbleTableViewDataSource`

You can always open and run the demo project which is located in `example` directory.

UIBubbleTableViewDataSource
-

There are 2 required methods to implement in the data source:

* `- (NSInteger)rowsForBubbleTable:(UIBubbleTableView *)tableView` - asks for how many message will be there
* `- (NSBubbleData *)bubbleTableView:(UIBubbleTableView *)tableView dataForRow:(NSInteger)row` - asks the nth message

`NSBubbleData` is a class which contains the user defined info related to the chat message. It includes:

* Message text (`NSString *text`)
* Message type: incoming or outgoing (`NSBubbleType type`)
* Message date (`NSDate *date`)

It's good idea to use `+ (id)dataWithText:(NSString *)text andDate:(NSDate *)date andType:(NSBubbleType)type` to create bubble data.

Messages grouping
-

The messages received within specified time interval will be grouped into one chat conversation. Each chat conversation prerendered with date label. You can change this time interval by setting `NSTimeInterval snapInterval` property  of `UIBubbleTableView`

Other colors for bubbles
-

You are welcome to create bubbles of any color you want. To archive this open the PSD files downloaded with the project in `psd` folder (you will need Adobe Photoshop), in the Shape layer change the Gradient overlay effect the way you want and save the file in PNG in the `images` folder.

Known limitations
-

* Works in portrait mode only. When turning the device into landscape mode, the width of the cells remains 320px.

Feedback
-
More features are coming soon. You are always welcome to ask questions, leave comments and report bugs with [https://github.com/AlexBarinov/UIBubbleTableView/issues](https://github.com/AlexBarinov/UIBubbleTableView/issues)