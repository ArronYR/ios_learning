## Todo App

原教程地址：[链接](http://www.imooc.com/video/5599)

+ 完全采用Autolayout实现界面
+ 使用Sketch重新制作了八个todo类型的icon
+ 详情页面的四个类型图片采用的``四等分``，适用各类屏幕
+ 在4s等小屏幕下内容过长会掩盖最下面的确定按钮，在左上角添加了同样功能的确定按钮，响应的事件与内容下方的属同一个。
+ 返回机制取消了原本的`` close(segue: UIStoryboardSegue) ``,在详情页面使用`` self.navigationController?.popViewControllerAnimated(true) ``返回主页。
+ 在主页中重写了``viewDidAppear``使得回到主页时刷新数据
```
override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    tableView.reloadData()
}
```

### 4s效果

![图片](http://images.helloarron.com/todo-4s-home.png)

![图片](http://images.helloarron.com/todo-4s-detail.png)


### 6效果

![图片](http://images.helloarron.com/Todo.gif)


