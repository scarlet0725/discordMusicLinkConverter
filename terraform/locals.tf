locals {
  container_definitions = jsonencode(
    [
      {
        "cpu" : 0,
        "environment" : [],
        "mountPoints" : [
        ],
        "workingDirectory" : null,
        "secrets" : [
          {
            "valueFrom" : "${aws_ssm_parameter.discord_bot_token.arn}",
            "name" : "DISCORD_TOKEN"
          },
          {
            "valueFrom" : "${aws_ssm_parameter.discord_category_id.arn}",
            "name" : "DISOCRD_CATEGORY_ID"
          }
        ],
        "memoryReservation" : 64,
        "image" : "${local.bot_image}",
        "name" : "discordMusicLinkConverter"
      }
    ]
  )
}

locals {
  task_definition = jsonencode(
    {
      "executionRoleArn" : "${aws_iam_role.bot_task_execution_role.arn}",
      "containerDefinitions" : [
        {
          "cpu" : 0,
          "environment" : [],
          "mountPoints" : [
          ],
          "workingDirectory" : null,
          "secrets" : [
            {
              "valueFrom" : "${aws_ssm_parameter.discord_bot_token.arn}",
              "name" : "DISCORD_TOKEN"
            },
            {
              "valueFrom" : "${aws_ssm_parameter.discord_category_id.arn}",
              "name" : "DISOCRD_CATEGORY_ID"
            }
          ],
          "memoryReservation" : 64,
          "image" : "${local.bot_image}",
          "name" : "discordMusicLinkConverter"
        }
      ],
      "taskRoleArn" : "${aws_iam_role.bot_task_role.arn}",
      "family" : "discordMusicLinkConverter",
      "requiresCompatibilities" : [
        "EC2"
      ],
      "networkMode" : "awsvpc",
      "volumes" : []
    }
  )
}

locals {
  bot_image     = "${var.ecr_uri}:${var.image_tag}"
  ecs_subnet_id = "subnet-037f3f23c4ac2d42b"
}