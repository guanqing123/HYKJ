// 1.获取RGB颜色
#define SPColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 2.自定义Log
#ifdef DEBUG  // 调试阶段
#define GQLog(...) NSLog(__VA_ARGS__)
#else   //发布阶段
#define GQLog(...)
#endif
