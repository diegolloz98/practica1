part of 'Images_bloc.dart';



abstract class ImagesEvent{}

class ImagesLoadEvent extends ImagesEvent{

}

class ImagesPullToRefreshEvent extends ImagesEvent{}
