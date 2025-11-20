resource "aws_alb" "app" {
  name               = "app-alb"
  load_balancer_type = "application"
  subnets            = var.public_subnets
  tags = {
    Name = "app-alb"
  }
}

resource "aws_alb_target_group" "tg" {
  name     = "app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_alb_listener" "listener" {
  load_balancer_arn = aws_alb.app.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.tg.arn
  }
}
resource "aws_lb_target_group_attachment" "attach" {
  target_group_arn = aws_alb_target_group.tg.arn
  target_id        = var.instance_id
  port             = 80
}
