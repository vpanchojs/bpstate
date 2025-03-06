class ToastService {
  late Function(String message) componentToast; 

  void registerComponent({required Function(String message) component}){
    componentToast = component;
  }

  void showMessage(String message){
    componentToast(message);
  }

}
