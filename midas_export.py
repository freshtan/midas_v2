
"""export midas."""
import numpy as np
from src.midas_net import MidasNet
from src.config import config
from mindspore import Tensor, export, context
from mindspore import dtype as mstype
from mindspore.train.serialization import load_checkpoint


def midas_export():
    """export midas."""
    context.set_context(
        mode=context.GRAPH_MODE,
        device_target="Ascend",
        save_graphs=False,
        device_id=config.device_id)
    net = MidasNet()
    load_checkpoint(config.model_weights, net=net)
    net.set_train(False)
    input_data = Tensor(np.zeros([1, 3, config.img_width, config.img_height]), mstype.float32)
    export(net, input_data, file_name='midas', file_format=config.file_format)


if __name__ == '__main__':
    midas_export()
