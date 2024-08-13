import android.view.LayoutInflater
import android.widget.Button
import android.widget.ImageView
import android.widget.RatingBar
import android.widget.TextView
import com.eserdeiro.common_impls.R
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import com.wortise.ads.flutter.natives.GoogleNativeAdFactory

class NativeTileAd(private val layoutInflater: LayoutInflater) : GoogleNativeAdFactory {

    override fun createNativeAd(nativeAd: NativeAd): NativeAdView {
        val adView = layoutInflater.inflate(R.layout.my_native_tile_ad, null) as NativeAdView

        val headlineView = adView.findViewById<TextView>(R.id.headline_tile)
        val bodyView = adView.findViewById<TextView>(R.id.body_tile)
        val iconView = adView.findViewById<ImageView>(R.id.icon_tile)
        val ratingBar = adView.findViewById<RatingBar>(R.id.star_rating_tile)
        val ctaButton = adView.findViewById<Button>(R.id.cta_button_tile)

        // Check if the ad has a headline asset
        if (nativeAd.headline != null) {
            headlineView.text = nativeAd.headline
            adView.setHeadlineView(headlineView)
        }

        // Check if the ad has a body text asset
        if (nativeAd.body != null) {
            bodyView.text = nativeAd.body
            adView.setBodyView(bodyView)
        }

        // Check if the ad has a icon
        val icon = nativeAd.icon

        if (icon != null) {
            iconView.setImageDrawable(icon.drawable)
            adView.setImageView(iconView)
        } else {
            iconView.visibility = ImageView.GONE
        }

        nativeAd.callToAction?.let {
            //            ctaButton.text = it
            ctaButton.visibility = Button.VISIBLE
            ctaButton.setBackgroundResource(R.drawable.ic_arrow_downward)
            adView.setCallToActionView(ctaButton)
        }
                ?: run {
                    ctaButton.visibility = Button.VISIBLE
                    ctaButton.setBackgroundResource(R.drawable.ic_arrow_forward)
                }

        // Verify star rating
        nativeAd.starRating?.let {
            if (it >= 0.0) {
                ratingBar.rating = it.toFloat()
                ratingBar.visibility = RatingBar.VISIBLE
            } else {
                ratingBar.visibility = RatingBar.GONE
            }
        }
                ?: run { ratingBar.visibility = RatingBar.GONE }

        adView.setNativeAd(nativeAd)
        return adView
    }
}
