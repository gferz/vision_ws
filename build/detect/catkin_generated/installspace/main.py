import rospy
from geometry_msgs.msg import Point
from yolov5.annotate import annotate
from yolov5.annotate import parse_args

class Main():
    def __init__(self):
        self.pub = rospy.Publisher('chatter', Point, queue_size=10)
        rospy.init_node('talkerpy', anonymous=True)
        self.rate = rospy.Rate(10) # 10hz

    def publish(self,x,y):
        point = Point(x,y,-1)
        self.pub.publish(point)

    def __call__(self):
        while not rospy.is_shutdown():
            args = parse_args()
            annotate(args,main_program = self)

if __name__ == '__main__':
    try:
        main = Main()
        main()
    except rospy.ROSInterruptException:
        pass