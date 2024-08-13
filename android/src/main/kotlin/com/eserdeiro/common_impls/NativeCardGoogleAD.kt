import android.view.LayoutInflater
import android.widget.Button
import android.widget.ImageView
import android.widget.RatingBar
import android.widget.TextView
import com.eserdeiro.common_impls.R
import com.google.android.gms.ads.nativead.MediaView
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import com.wortise.ads.flutter.natives.GoogleNativeAdFactory

class NativeCardGoogleAD(private val layoutInflater: LayoutInflater) : GoogleNativeAdFactory {

    override fun createNativeAd(nativeAd: NativeAd): NativeAdView {
        val adView = layoutInflater.inflate(R.layout.my_native_card_ad_google, null) as NativeAdView

        val headlineView = adView.findViewById<TextView>(R.id.primary)

        val bodyView = adView.findViewById<TextView>(R.id.body)

        val mediaView = adView.findViewById<MediaView>(R.id.media_view_google)

        val imageView = adView.findViewById<ImageView>(R.id.image_card_google)

        val iconView = adView.findViewById<ImageView>(R.id.icon_google)

        val ratingBar = adView.findViewById<RatingBar>(R.id.rating_bar)

        val ctaButton = adView.findViewById<Button>(R.id.cta)

        // Verify title
        nativeAd.headline?.let {
            headlineView.text = it
            adView.headlineView = headlineView
        }

        // Verify body
        nativeAd.body?.let {
            bodyView.text = it
            adView.bodyView = bodyView
        }

        // Verify media content
        if (nativeAd.mediaContent != null) {
            mediaView.mediaContent = nativeAd.mediaContent
            mediaView.visibility = MediaView.VISIBLE
            imageView.visibility = ImageView.GONE
            adView.mediaView = mediaView
        } else if (nativeAd.images.isNotEmpty() && nativeAd.images[0].drawable != null) {
            imageView.setImageDrawable(nativeAd.images[0].drawable)
            imageView.visibility = ImageView.VISIBLE
            mediaView.visibility = MediaView.GONE
            adView.imageView = imageView
        } else {
            imageView.visibility = ImageView.GONE
            mediaView.visibility = MediaView.GONE
        }

        // Verify icon
        nativeAd.icon?.drawable?.let {
            iconView.setImageDrawable(it)
            iconView.visibility = ImageView.VISIBLE
            adView.iconView = iconView
        } ?: run {
            iconView.visibility = ImageView.GONE
        }

        // Verify button
        nativeAd.callToAction?.let {
            ctaButton.text = it
            ctaButton.visibility = Button.VISIBLE
            adView.callToActionView = ctaButton
        }
                ?: run { ctaButton.visibility = Button.GONE }

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
