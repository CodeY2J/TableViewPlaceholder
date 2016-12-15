# TableViewPlaceholder
swift版 快速实现UITableView异常占位图
***
###展示
![image1](test.gif)
***
###使用  
1 占位图设置 

	   tableView.placeholder = {[weak self] _ in
	       if let _self = self {
				#if 网络错误 {
					return 网络错误视图
				} else if 无数据 {
					return 无数据视图
				}
	       }
	       return UIView()
	   }   
2 用`tableView.lmk_reloadData()`替换`tableView.reloadData()`
